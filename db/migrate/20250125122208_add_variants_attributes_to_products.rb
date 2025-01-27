# frozen_string_literal: true

class AddVariantsAttributesToProducts < ActiveRecord::Migration[8.0]
  def change
    change_table :products, bulk: true do |t|
      t.string :sku
      t.string :upc
      t.monetize :buying_amount
      t.monetize :tax_free_amount
      t.integer :quantity, default: 0
      t.belongs_to :provider, foreign_key: true, type: :uuid
    end
  end
end
