# frozen_string_literal: true

class CreateOrderVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :order_variants, id: :uuid do |t|
      t.belongs_to :variant, foreign_key: true, type: :uuid
      t.belongs_to :order, foreign_key: true, type: :uuid
      t.integer :quantity

      t.timestamps
    end
  end
end
