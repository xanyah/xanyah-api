class AddingInfosToStores < ActiveRecord::Migration[8.0]
  def change
    change_table :stores, bulk: true do |t|
      t.rename :address, :address1
      t.string :address2
      t.string :zipcode
      t.string :website_url
      t.string :phone_number
      t.string :email_address
      t.string :color
      t.string :city
    end
  end
end
