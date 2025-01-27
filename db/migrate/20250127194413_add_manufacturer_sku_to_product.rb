class AddManufacturerSkuToProduct < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :manufacturer_sku, :string
  end
end
