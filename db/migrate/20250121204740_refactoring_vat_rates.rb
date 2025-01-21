# frozen_string_literal: true

class RefactoringVatRates < ActiveRecord::Migration[8.0]
  def change
    drop_table :vat_rates, id: :uuid do |t|
      t.string :country_code
      t.string :country_name
      t.float :standard_rate
      t.float :reduced_rate
      t.float :reduced_rate_alt
      t.float :super_reduced_rate
      t.float :parking_rate
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.datetime :deleted_at, index: true
    end

    create_table :vat_rates, id: :uuid do |t|
      t.belongs_to :country, type: :uuid
      t.integer :rate_percent_cents

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
