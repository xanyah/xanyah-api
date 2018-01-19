class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :label
      t.integer :tva

      t.belongs_to :store, foreign_key: true, type: :uuid
      t.belongs_to :category, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
