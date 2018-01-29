class Manufacturer < ApplicationRecord
  belongs_to :store, optional: false

  has_many :products

  validates :name, presence: true
end
