# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VatRatesController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/vat_rates').to route_to('vat_rates#index')
    end

    it 'routes to #show' do
      expect(get: '/vat_rates/1').to route_to('vat_rates#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/vat_rates').not_to route_to('vat_rates#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/vat_rates/1').not_to route_to('vat_rates#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/vat_rates/1').not_to route_to('vat_rates#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/vat_rates/1').not_to route_to('vat_rates#destroy', id: '1')
    end
  end
end
