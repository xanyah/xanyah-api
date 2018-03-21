# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InventoryVariantsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/inventory_variants').to route_to('inventory_variants#index')
    end

    it 'routes to #show' do
      expect(get: '/inventory_variants/1').to route_to('inventory_variants#show', id: '1')
    end

    it 'routes to #by_variant' do
      expect(get: '/inventory_variants/1/2').to route_to('inventory_variants#by_variant',
                                                        inventory_id: '1',
                                                        variant_id:  '2')
    end

    it 'routes to #create' do
      expect(post: '/inventory_variants').to route_to('inventory_variants#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/inventory_variants/1').to route_to('inventory_variants#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/inventory_variants/1').to route_to('inventory_variants#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/inventory_variants/1').to route_to('inventory_variants#destroy', id: '1')
    end
  end
end
