class CreateInventories < ActiveRecord::Migration[5.1]
  def change
    create_table :inventories, id: :uuid do |t|
      t.datetime :locked_at

      t.belongs_to :store, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
