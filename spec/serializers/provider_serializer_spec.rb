# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProviderSerializer do
  let(:provider) { create(:provider) }
  let(:serializer) { described_class.new(provider) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let(:json) { JSON.parse(serialization.to_json) }
  let(:default_attributes) {
    %w[
      id
      name
      created_at
      updated_at
      notes
      store_id
    ]
  }

  it :default_attributes do
    default_attributes.each do |attribute|
      if provider.send(attribute).class == ActiveSupport::TimeWithZone
        expect(Time.zone.parse(json[attribute]).to_s).to eq(provider.send(attribute).to_s)
      else
        expect(json[attribute]).to eq(provider.send(attribute))
      end
    end
  end

  describe 'counts' do
    it :shippings do
      create(:shipping, provider: provider)
      expect(json['shippings_count']).to eq(1)
    end
  end
end
