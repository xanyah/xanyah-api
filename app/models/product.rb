# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category, optional: false
  belongs_to :manufacturer, optional: false
  belongs_to :store, optional: false
  has_many :variants, dependent: :destroy
  has_many :providers, through: :variants

  validates :name, presence: true
  validate :common_store

  protected

  def common_store
    errors.add(:category, 'must belong to store') if category.nil? || category.store != store
    errors.add(:manufacturer, 'must belong to store') if manufacturer.nil? || manufacturer.store != store
  end
end
