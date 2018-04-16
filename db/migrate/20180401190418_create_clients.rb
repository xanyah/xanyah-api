# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients, id: :uuid do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :phone
      t.string :address
      t.text :notes

      t.belongs_to :store, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
