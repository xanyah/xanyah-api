class AddingFirstAndLastNameToUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :name, :firstname
    add_column :users, :lastname, :string
  end
end
