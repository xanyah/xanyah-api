class CreateSalePromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :sale_promotions, id: :uuid do |t|
      t.integer :type
      t.float :amount
      t.belongs_to :sale, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
