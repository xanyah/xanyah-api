class CreateSales < ActiveRecord::Migration[5.1]
  def change
    create_table :sales, id: :uuid do |t|
      t.boolean :completed, default: false
      t.float :total_price
      
      t.belongs_to :client, foreign_key: true, type: :uuid
      t.belongs_to :store, foreign_key: true, type: :uuid
      t.belongs_to :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
