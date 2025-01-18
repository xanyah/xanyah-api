# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StockBackupVariantsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/stock_backup_variants').to route_to('stock_backup_variants#index')
    end

    it 'routes to #show' do
      expect(get: '/stock_backup_variants/1').to route_to('stock_backup_variants#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/stock_backup_variants').not_to route_to('stock_backup_variants#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/stock_backup_variants/1').not_to route_to('stock_backup_variants#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/stock_backup_variants/1').not_to route_to('stock_backup_variants#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/stock_backup_variants/1').not_to route_to('stock_backup_variants#destroy', id: '1')
    end
  end
end
