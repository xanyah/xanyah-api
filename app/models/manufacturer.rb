# frozen_string_literal: true

class Manufacturer < ApplicationRecord
  belongs_to :store, optional: false

  has_many :products, dependent: :destroy

  validates :name, presence: true
end
