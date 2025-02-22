# frozen_string_literal: true

class AddVatRateToProducts < ActiveRecord::Migration[8.0]
  def change
    add_reference :products, :vat_rate, type: :uuid, index: true
    remove_reference :categories, :vat_rate, type: :uuid, index: true
  end
end
