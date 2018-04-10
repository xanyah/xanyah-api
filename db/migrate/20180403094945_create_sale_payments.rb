class CreateSalePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :sale_payments, id: :uuid do |t|
      t.float :total

      t.belongs_to :payment_type, foreign_key: true, type: :uuid
      t.belongs_to :sale, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
