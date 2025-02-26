# frozen_string_literal: true

class DestroyStockBackups < ActiveRecord::Migration[8.0]
  def change
    drop_table :stock_backup_variants, id: :uuid do |t|
      t.integer :quantity
      t.belongs_to :stock_backup
      t.belongs_to :variant
      t.datetime :deleted_at

      t.timestamps
    end

    drop_table :stock_backups, id: :uuid do |t|
      t.belongs_to :store_id
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
