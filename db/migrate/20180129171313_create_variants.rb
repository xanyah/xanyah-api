# frozen_string_literal: true

class CreateVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :variants, id: :uuid do |t|
      t.string :original_barcode
      t.string :barcode
      t.float :buying_price, default: 0
      t.float :tax_free_price, default: 0
      t.float :ratio, default: 0
      t.integer :quantity, default: 0
      t.boolean :default

      t.belongs_to :product, foreign_key: true, type: :uuid
      t.belongs_to :provider, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
