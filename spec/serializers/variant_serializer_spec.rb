# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VariantSerializer do
  let(:variant) { create(:variant) }
  let(:serializer) { described_class.new(variant) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let(:json) { JSON.parse(serialization.to_json) }
  let(:default_attributes) do
    %w[
      id
      original_barcode
      barcode
      buying_price
      tax_free_price
      ratio
      quantity
      default
      created_at
      updated_at
    ]
  end

  it :default_attributes do
    default_attributes.each do |attribute|
      if variant.send(attribute).instance_of?(ActiveSupport::TimeWithZone)
        expect(Time.zone.parse(json[attribute]).to_s).to eq(variant.send(attribute).to_s)
      else
        expect(json[attribute]).to eq(variant.send(attribute))
      end
    end
  end

  describe 'belongs_to' do
    it :product do
      expect(json['product']['id']).to eq(variant.product.id)
      expect(json['product']['name']).to eq(variant.product.name)
      expect(json['product']['manufacturer']['name']).to eq(variant.product.manufacturer.name)
    end

    it :provider do
      expect(json['provider']['id']).to eq(variant.provider.id)
      expect(json['provider']['name']).to eq(variant.provider.name)
    end
  end

  describe 'has_many' do
    it :variant_attributes do
      create(:variant_attribute, variant: variant)
      expect(json['variant_attributes'].size).to eq(1)
    end
  end
end
