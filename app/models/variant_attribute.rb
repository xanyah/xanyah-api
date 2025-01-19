# frozen_string_literal: true

class VariantAttribute < ApplicationRecord
  belongs_to :variant, optional: false
  belongs_to :custom_attribute, optional: false
  has_one :product, through: :variant
  has_one :store, through: :variant

  validates :custom_attribute_id, uniqueness: { scope: :variant_id }
end
