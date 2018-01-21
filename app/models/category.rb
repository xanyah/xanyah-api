class Category < ApplicationRecord
  belongs_to :store
  belongs_to :category, optional: true

  enum tva: [:standard_rate, :reduced_rate, :reduced_rate_alt, :super_reduced_rate, :parking_rate]

  validates :tva, presence: true
  validates :label, presence: true, uniqueness: {scope: :store_id}

  scope :without_category, ->() { where(category_id: nil) }
  scope :children_of, ->(id) { where(category_id: id) }
end
