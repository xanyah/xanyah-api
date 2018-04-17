# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :store, optional: false
  belongs_to :category, optional: true

  enum tva: %i[
    standard_rate
    reduced_rate_alt
    reduced_rate
    super_reduced_rate
    parking_rate
  ]

  validates :tva, presence: true
  validates :name, presence: true, uniqueness: {scope: :category}

  scope :without_category, -> { where(category_id: nil) }
  scope :children_of, ->(id) { where(category_id: id) }
end
