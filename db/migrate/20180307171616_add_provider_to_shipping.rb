# frozen_string_literal: true

class AddProviderToShipping < ActiveRecord::Migration[5.1]
  def change
    add_reference :shippings, :provider, type: :uuid, index: true
  end
end
