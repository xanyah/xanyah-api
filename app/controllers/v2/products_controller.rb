# frozen_string_literal: true

module V2
  class ProductsController < ResourcesController
    def included_relationships
      [:manufacturer, { category: [:category], product_custom_attributes: [:custom_attribute] }]
    end
  end
end
