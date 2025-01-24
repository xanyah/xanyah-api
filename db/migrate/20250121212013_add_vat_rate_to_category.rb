# frozen_string_literal: true

class AddVatRateToCategory < ActiveRecord::Migration[8.0]
  def change
    change_table :categories do |t|
      t.remove :tva, type: :integer
      t.belongs_to :vat_rate, type: :uuid
    end
  end
end
