class CreateInventoryVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :inventory_variants, id: :uuid do |t|
      t.integer :quantity
      t.belongs_to :inventory, foreign_key: true, type: :uuid
      t.belongs_to :variant, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
