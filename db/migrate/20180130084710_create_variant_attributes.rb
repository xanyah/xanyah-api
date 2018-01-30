class CreateVariantAttributes < ActiveRecord::Migration[5.1]
  def change
    create_table :variant_attributes, id: :uuid do |t|
      t.string :value

      t.belongs_to :variant, foreign_key: true, type: :uuid
      t.belongs_to :custom_attribute, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
