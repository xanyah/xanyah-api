# frozen_string_literal: true

class CustomAttribute < ApplicationRecord
  enum :type, { text: 0, number: 1 }
  belongs_to :store, optional: false

  has_many :variant_attributes, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :store }
  validates :type, presence: true

  self.inheritance_column = :_type_disabled
end
