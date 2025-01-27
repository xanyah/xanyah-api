# frozen_string_literal: true

class CreateInventoryProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :inventory_products, id: :uuid do |t|
      t.belongs_to :product, null: false, foreign_key: true, type: :uuid
      t.belongs_to :inventory, null: false, foreign_key: true, type: :uuid
      t.integer :quantity, default: 1
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
