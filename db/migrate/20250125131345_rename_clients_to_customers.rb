class RenameClientsToCustomers < ActiveRecord::Migration[8.0]
  def change
    rename_table :clients, :customers
    rename_column :orders, :client_id, :customer_id
    rename_column :sales, :client_id, :customer_id
  end
end
