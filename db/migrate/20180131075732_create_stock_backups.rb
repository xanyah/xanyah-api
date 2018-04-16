# frozen_string_literal: true

class CreateStockBackups < ActiveRecord::Migration[5.1]
  def change
    create_table :stock_backups, id: :uuid do |t|
      t.belongs_to :store, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
