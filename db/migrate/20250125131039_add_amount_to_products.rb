class AddAmountToProducts < ActiveRecord::Migration[8.0]
  def change
    change_table :products, bulk: true do |t|
      t.monetize :amount
    end
  end
end
