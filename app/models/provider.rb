# frozen_string_literal: true

class Provider < ApplicationRecord
  belongs_to :store, optional: false

  has_many :shippings, dependent: :destroy
  has_many :products, dependent: :destroy

  validates :name, presence: true
end
