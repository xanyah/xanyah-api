# frozen_string_literal: true

class CustomAttribute < ApplicationRecord
  enum type: %i[text number]
  belongs_to :store, optional: false

  has_many :variant_attributes, dependent: :destroy

  validates :name, presence: true
  validates :type, presence: true

  self.inheritance_column = :_type_disabled
end
