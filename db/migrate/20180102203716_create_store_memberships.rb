class CreateStoreMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :store_memberships, id: :uuid do |t|
      t.belongs_to :store, foreign_key: true, type: :uuid
      t.belongs_to :user, foreign_key: true, type: :uuid
      t.integer :role

      t.timestamps
    end
  end
end
