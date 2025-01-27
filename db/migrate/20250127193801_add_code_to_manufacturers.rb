# frozen_string_literal: true

class AddCodeToManufacturers < ActiveRecord::Migration[8.0]
  def change
    add_column :manufacturers, :code, :string
  end
end
