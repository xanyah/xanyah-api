# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InventoriesController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/inventories').to route_to('inventories#index')
    end

    it 'routes to #show' do
      expect(get: '/inventories/1').to route_to('inventories#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/inventories').to route_to('inventories#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/inventories/1').not_to route_to('inventories#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/inventories/1').not_to route_to('inventories#update', id: '1')
    end

    it 'routes to #lock via PUT' do
      expect(put: '/inventories/1/lock').to route_to('inventories#lock', id: '1')
    end

    it 'routes to #lock via PATCH' do
      expect(patch: '/inventories/1/lock').to route_to('inventories#lock', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/inventories/1').to route_to('inventories#destroy', id: '1')
    end
  end
end
