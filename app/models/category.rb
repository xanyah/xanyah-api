# frozen_string_literal: true

class Category < ApplicationRecord
  before_validation :set_tva
  belongs_to :store, optional: false
  belongs_to :category, optional: true

  enum tva: { standard_rate: 0, reduced_rate_alt: 1, reduced_rate: 2, super_reduced_rate: 3, parking_rate: 4 }

  validates :tva, presence: true
  validates :name, presence: true, uniqueness: { scope: :category }

  scope :without_category, -> { where(category_id: nil) }
  scope :children_of, ->(id) { where(category_id: id) }

  protected

  def set_tva
    self.tva = :standard_rate if tva.nil?
  end
end
