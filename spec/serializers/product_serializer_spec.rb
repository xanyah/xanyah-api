# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductSerializer do
  let(:product) { create(:product) }
  let(:serializer) { described_class.new(product) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let(:json) { JSON.parse(serialization.to_json) }
  let(:default_attributes) {
    %w[
      id
      name
      created_at
      updated_at
    ]
  }

  it :default_attributes do
    default_attributes.each do |attribute|
      if product.send(attribute).class == ActiveSupport::TimeWithZone
        expect(Time.zone.parse(json[attribute]).to_s).to eq(product.send(attribute).to_s)
      else
        expect(json[attribute]).to eq(product.send(attribute))
      end
    end
  end

  describe 'belongs_to' do
    it :category do
      expect(json['category']['id']).to eq(product.category.id)
      expect(json['category']['name']).to eq(product.category.name)
    end

    it :manufacturer do
      expect(json['manufacturer']['id']).to eq(product.manufacturer.id)
      expect(json['manufacturer']['name']).to eq(product.manufacturer.name)
    end
  end
end
