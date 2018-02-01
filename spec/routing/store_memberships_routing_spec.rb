# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoreMembershipsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/store_memberships').to route_to('store_memberships#index')
    end

    it 'routes to #show' do
      expect(get: '/store_memberships/1').to route_to('store_memberships#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/store_memberships').to route_to('store_memberships#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/store_memberships/1').to route_to('store_memberships#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/store_memberships/1').to route_to('store_memberships#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/store_memberships/1').to route_to('store_memberships#destroy', id: '1')
    end
  end
end
