# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentTypesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/payment_types').to route_to('payment_types#index')
    end

    it 'routes to #show' do
      expect(get: '/payment_types/1').to route_to('payment_types#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/payment_types').to route_to('payment_types#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/payment_types/1').to route_to('payment_types#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/payment_types/1').to route_to('payment_types#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/payment_types/1').not_to route_to('payment_types#destroy', id: '1')
    end
  end
end
