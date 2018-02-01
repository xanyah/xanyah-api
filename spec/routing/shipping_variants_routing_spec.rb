# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShippingVariantsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/shipping_variants').to route_to('shipping_variants#index')
    end

    it 'routes to #show' do
      expect(get: '/shipping_variants/1').to route_to('shipping_variants#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/shipping_variants').to route_to('shipping_variants#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/shipping_variants/1').to route_to('shipping_variants#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/shipping_variants/1').to route_to('shipping_variants#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/shipping_variants/1').to route_to('shipping_variants#destroy', id: '1')
    end
  end
end
