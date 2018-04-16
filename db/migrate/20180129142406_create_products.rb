# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name

      t.belongs_to :category, foreign_key: true, type: :uuid
      t.belongs_to :manufacturer, foreign_key: true, type: :uuid
      t.belongs_to :store, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
