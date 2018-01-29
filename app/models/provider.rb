class Provider < ApplicationRecord
  belongs_to :store, optional: false

  validates :name, presence: true
end
