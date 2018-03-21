# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InventoryVariantSerializer do
  let(:inventory_variant) { create(:inventory_variant) }
  let(:serializer) { described_class.new(inventory_variant) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let(:json) { JSON.parse(serialization.to_json) }
  let(:default_attributes) {
    %w[
      id
      quantity
      created_at
      updated_at
    ]
  }

  it :default_attributes do
    default_attributes.each do |attribute|
      if inventory_variant.send(attribute).class == ActiveSupport::TimeWithZone
        expect(Time.zone.parse(json[attribute]).to_s).to eq(inventory_variant.send(attribute).to_s)
      else
        expect(json[attribute]).to eq(inventory_variant.send(attribute))
      end
    end
  end

  describe 'belongs_to' do
    it :variant do
      expect(json['variant']['id']).to eq(inventory_variant.variant.id)
      expect(json['variant']['product']['id']).to eq(inventory_variant.variant.product.id)
    end

    it :provider do
      expect(json['inventory']['id']).to eq(inventory_variant.inventory.id)
    end
  end
end
