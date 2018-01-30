class Product < ApplicationRecord
  belongs_to :category, optional: false
  belongs_to :manufacturer, optional: false
  belongs_to :store, optional: false
  has_many :variants

  validates :name, presence: true
  validate :common_store

  protected
  def common_store
    errors.add(:category, 'must belong to store') if self.category.nil? || self.category.store != self.store
    errors.add(:manufacturer, 'must belong to store') if self.manufacturer.nil? || self.manufacturer.store != self.store
  end
end
