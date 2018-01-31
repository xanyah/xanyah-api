# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VariantAttributesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/variant_attributes').to route_to('variant_attributes#index')
    end

    it 'routes to #show' do
      expect(get: '/variant_attributes/1').to route_to('variant_attributes#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/variant_attributes').to route_to('variant_attributes#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/variant_attributes/1').to route_to('variant_attributes#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/variant_attributes/1').to route_to('variant_attributes#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/variant_attributes/1').to route_to('variant_attributes#destroy', id: '1')
    end
  end
end
