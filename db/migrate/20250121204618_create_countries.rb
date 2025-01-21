# frozen_string_literal: true

class CreateCountries < ActiveRecord::Migration[8.0]
  def change
    create_table :countries, id: :uuid do |t|
      t.string :name
      t.string :code

      t.timestamps
      t.datetime :deleted_at
    end

    add_index :countries, :name, unique: true
    add_index :countries, :code, unique: true
  end
end
