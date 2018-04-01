# frozen_string_literal: true

class Client < ApplicationRecord
  belongs_to :store, optional: false
end
