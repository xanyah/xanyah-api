class CreateVatRates < ActiveRecord::Migration[5.1]
  def change
    create_table :vat_rates, id: :uuid do |t|
      t.string :country_code
      t.string :country_name
      t.float :standard_rate
      t.float :reduced_rate
      t.float :reduced_rate_alt
      t.float :super_reduced_rate
      t.float :parking_rate

      t.timestamps
    end
  end
end
