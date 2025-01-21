class AddCountryToStores < ActiveRecord::Migration[8.0]
  def change
    change_table :stores do |t|
      t.remove :country, type: :string
      t.belongs_to :country, type: :uuid
    end
  end
end
