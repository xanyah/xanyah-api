# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders, id: :uuid do |t|
      t.integer :status, default: 0

      t.belongs_to :client, foreign_key: true, type: :uuid
      t.belongs_to :store, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
