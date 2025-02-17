# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoreSerializer do
  let(:membership) { create(:store_membership) }
  let(:store) { membership.store }
  let(:serializer) { described_class.new(store, scope: membership.user) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let(:json) { JSON.parse(serialization.to_json) }
  let(:default_attributes) do
    %w[
      id
      name
      key
      address1
      created_at
      updated_at
    ]
  end

  it :default_attributes do
    default_attributes.each do |attribute|
      if store.send(attribute).instance_of?(ActiveSupport::TimeWithZone)
        expect(Time.zone.parse(json[attribute]).to_s).to eq(store.send(attribute).to_s)
      else
        expect(json[attribute]).to eq(store.send(attribute))
      end
    end
  end
end
