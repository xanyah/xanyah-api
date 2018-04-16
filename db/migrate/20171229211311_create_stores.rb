# frozen_string_literal: true

class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores, id: :uuid do |t|
      t.string :key
      t.string :name
      t.string :address
      t.string :country

      t.timestamps
    end
  end
end
