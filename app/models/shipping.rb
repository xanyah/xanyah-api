# frozen_string_literal: true

class Shipping < ApplicationRecord
  belongs_to :store, optional: false

  def lock
    self.locked_at = Time.zone.now
    save
  end
end
