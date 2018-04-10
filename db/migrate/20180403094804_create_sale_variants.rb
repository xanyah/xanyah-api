class CreateSaleVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :sale_variants, id: :uuid do |t|
      t.integer :quantity
      t.float :unit_price
      
      t.belongs_to :sale, foreign_key: true, type: :uuid
      t.belongs_to :variant, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
