class CreatePaymentTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_types, id: :uuid do |t|
      t.string :name
      t.text :description

      t.belongs_to :store, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
