class CreateSaleProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :sale_products, id: :uuid do |t|
      t.integer :quantity, default: 1
      t.belongs_to :sale, null: false, foreign_key: true, type: :uuid
      t.belongs_to :product, null: false, foreign_key: true, type: :uuid
      t.monetize :original_amount
      t.monetize :amount
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
