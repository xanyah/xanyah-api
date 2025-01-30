# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id,
             :name,
             :amount_cents,
             :amount_currency,
             :buying_amount_cents,
             :buying_amount_currency,
             :tax_free_amount_cents,
             :tax_free_amount_currency,
             :sku,
             :upc,
             :manufacturer_sku,
             :images

  belongs_to :category
  belongs_to :manufacturer

  def images
    object.images.map do |image|
      {
        open_graph: image_variant_path(image, :open_graph),
        thumbnail: image_variant_path(image, :thumbnail),
        medium: image_variant_path(image, :medium),
        large: image_variant_path(image, :large)
      }
    end
  end

  private

  def image_variant_path(image, variant)
    rails_representation_url(image.variant(variant), only_path: true)
  end
end
