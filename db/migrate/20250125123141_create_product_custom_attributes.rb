# frozen_string_literal: true

class CreateProductCustomAttributes < ActiveRecord::Migration[8.0]
  def change
    create_table :product_custom_attributes, id: :uuid do |t|
      t.belongs_to :product, null: false, foreign_key: true, type: :uuid
      t.belongs_to :custom_attribute, null: false, foreign_key: true, type: :uuid
      t.string :value

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
