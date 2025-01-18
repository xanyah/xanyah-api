# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShippingVariantSerializer do
  let(:shipping_variant) { create(:shipping_variant) }
  let(:serializer) { described_class.new(shipping_variant) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let(:json) { JSON.parse(serialization.to_json) }
  let(:default_attributes) do
    %w[
      id
      quantity
      created_at
      updated_at
    ]
  end

  it :default_attributes do
    default_attributes.each do |attribute|
      if shipping_variant.send(attribute).instance_of?(ActiveSupport::TimeWithZone)
        expect(Time.zone.parse(json[attribute]).to_s).to eq(shipping_variant.send(attribute).to_s)
      else
        expect(json[attribute]).to eq(shipping_variant.send(attribute))
      end
    end
  end

  describe 'belongs_to' do
    it :variant do
      expect(json['variant']['id']).to eq(shipping_variant.variant.id)
      expect(json['variant']['product']['id']).to eq(shipping_variant.variant.product.id)
    end

    it :provider do
      expect(json['shipping']['id']).to eq(shipping_variant.shipping.id)
    end
  end
end
