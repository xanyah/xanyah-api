# frozen_string_literal: true

class ProductCustomAttribute < ApplicationRecord
  belongs_to :product
  belongs_to :custom_attribute
end
