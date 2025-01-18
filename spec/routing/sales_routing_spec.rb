# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalesController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/sales').to route_to('sales#index')
    end

    it 'routes to #show' do
      expect(get: '/sales/1').to route_to('sales#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/sales').to route_to('sales#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/sales/1').not_to route_to('sales#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/sales/1').not_to route_to('sales#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/sales/1').to route_to('sales#destroy', id: '1')
    end
  end
end
