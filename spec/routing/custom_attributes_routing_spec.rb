# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomAttributesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/custom_attributes').to route_to('custom_attributes#index')
    end

    it 'routes to #show' do
      expect(get: '/custom_attributes/1').to route_to('custom_attributes#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/custom_attributes').to route_to('custom_attributes#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/custom_attributes/1').to route_to('custom_attributes#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/custom_attributes/1').to route_to('custom_attributes#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/custom_attributes/1').to route_to('custom_attributes#destroy', id: '1')
    end
  end
end
