# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ManufacturerSerializer do
  let(:store) { create(:store) }
  let(:manufacturer) { create(:manufacturer, store: store) }
  let(:serializer) { described_class.new(manufacturer) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let(:json) { JSON.parse(serialization.to_json) }
  let(:default_attributes) do
    %w[
      id
      name
      created_at
      updated_at
      notes
      store_id
    ]
  end

  it :default_attributes do
    default_attributes.each do |attribute|
      if manufacturer.send(attribute).instance_of?(ActiveSupport::TimeWithZone)
        expect(Time.zone.parse(json[attribute]).to_s).to eq(manufacturer.send(attribute).to_s)
      else
        expect(json[attribute]).to eq(manufacturer.send(attribute))
      end
    end
  end

  describe 'counts' do
    it :products do
      create(:product, manufacturer: manufacturer, store: store)
      expect(json['products_count']).to eq(1)
    end
  end
end
