class CreateStockBackupVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :stock_backup_variants, id: :uuid do |t|
      t.integer :quantity
      
      t.belongs_to :stock_backup, foreign_key: true, type: :uuid
      t.belongs_to :variant, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
