# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShippingsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/shippings').to route_to('shippings#index')
    end

    it 'routes to #show' do
      expect(get: '/shippings/1').to route_to('shippings#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/shippings').to route_to('shippings#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/shippings/1').not_to route_to('shippings#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/shippings/1').not_to route_to('shippings#update', id: '1')
    end

    it 'routes to #lock via PUT' do
      expect(put: '/shippings/1/lock').to route_to('shippings#lock', id: '1')
    end

    it 'routes to #lock via PATCH' do
      expect(patch: '/shippings/1/lock').to route_to('shippings#lock', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/shippings/1').to route_to('shippings#destroy', id: '1')
    end
  end
end
