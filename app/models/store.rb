class Store < ApplicationRecord
  validates :key, presence: true, uniqueness: true, allow_nil: false
end
