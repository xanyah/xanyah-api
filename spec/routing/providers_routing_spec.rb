# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProvidersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/providers').to route_to('providers#index')
    end

    it 'routes to #show' do
      expect(get: '/providers/1').to route_to('providers#show', id: '1')
    end

    it 'routes to #search' do
      expect(get: '/providers/search').to route_to('providers#search')
    end

    it 'routes to #create' do
      expect(post: '/providers').to route_to('providers#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/providers/1').to route_to('providers#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/providers/1').to route_to('providers#update', id: '1')
    end
  end
end
