# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VariantSerializer do
  let(:variant) { create(:variant) }
  let(:serializer) { described_class.new(variant) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let(:json) { JSON.parse(serialization.to_json) }
  let(:default_attributes) {
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
  }

  it :default_attributes do
    default_attributes.each do |attribute|
      if variant.send(attribute).class == ActiveSupport::TimeWithZone
        expect(Time.parse(json[attribute]).to_s).to eq(variant.send(attribute).to_s)
      else
        expect(json[attribute]).to eq(variant.send(attribute))
      end
    end
  end

  describe 'belongs_to' do
    it :product do
      expect(json['product']['id']).to eq(variant.product.id)
      expect(json['product']['name']).to eq(variant.product.name)
    end
  end

  describe 'belongs_to' do
    it :provider do
      expect(json['provider']['id']).to eq(variant.provider.id)
      expect(json['provider']['name']).to eq(variant.provider.name)
    end
  end
end
