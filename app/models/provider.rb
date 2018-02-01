# frozen_string_literal: true

class Provider < ApplicationRecord
  belongs_to :store, optional: false

  validates :name, presence: true
end
