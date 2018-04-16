# frozen_string_literal: true

class CreateShippingVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :shipping_variants, id: :uuid do |t|
      t.integer :quantity

      t.belongs_to :shipping, foreign_key: true, type: :uuid
      t.belongs_to :variant, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
