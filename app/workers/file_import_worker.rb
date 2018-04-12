# frozen_string_literal: true

require 'csv'
require 'json'

class FileImportWorker
  include Sidekiq::Worker

  def perform(object_path, store_id)
    @store_id = store_id
    tempfile = Tempfile.new([File.basename(object_path, '.*'), File.extname(object_path)])
    object = S3_BUCKET.object(object_path)
    object.get(response_target: tempfile.path)

    ActiveRecord::Base.transaction do
      case File.extname(tempfile.path)
      when '.csv'
        CSV.foreach(tempfile.path, headers: true, encoding: 'UTF-8') do |row|
          create_product row.to_hash
        end
      when '.json'
        JSON.parse(tempfile.read).each do |row|
          create_product row
        end
      end
    end

    object.delete
  end

  def create_product(params)
    manufacturer = Manufacturer.find_or_create_by(name: params['product_manufacturer'], store_id: @store_id)
    provider = Provider.find_or_create_by(name: params['variant_provider'], store_id: @store_id)
    category = Category.find_or_create_by(name: params['product_category'], store_id: @store_id)
    product = Product.create!(
      name:         params['product_name'],
      category:     category,
      manufacturer: manufacturer,
      store_id:     @store_id
    )
    Variant.create!(
      original_barcode: params['variant_original_barcode'],
      buying_price:     params['variant_buying_price'].to_f,
      tax_free_price:   params['variant_tax_free_price'].to_f,
      ratio:            params['variant_ratio'].to_f,
      provider:         provider,
      product:          product
    )
  end
end
