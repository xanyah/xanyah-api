# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StockBackupsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/stock_backups').to route_to('stock_backups#index')
    end

    it 'routes to #show' do
      expect(get: '/stock_backups/1').to route_to('stock_backups#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/stock_backups').not_to route_to('stock_backups#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/stock_backups/1').not_to route_to('stock_backups#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/stock_backups/1').not_to route_to('stock_backups#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/stock_backups/1').not_to route_to('stock_backups#destroy', id: '1')
    end
  end
end
