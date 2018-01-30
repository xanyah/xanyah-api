class CreateCustomAttributes < ActiveRecord::Migration[5.1]
  def change
    create_table :custom_attributes, id: :uuid do |t|
      t.string :name
      t.integer :type

      t.belongs_to :store, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
