# frozen_string_literal: true

class Customer < ApplicationRecord
  belongs_to :store, optional: false
end
