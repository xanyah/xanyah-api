class DroppingVariants < ActiveRecord::Migration[8.0]
  def change
    drop_table :inventory_variants do |t|
      t.integer :quantity
      t.belongs_to :inventory
      t.belongs_to :variant
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.datetime :deleted_at
    end

    drop_table :order_variants do |t|
      t.belongs_to :variant
      t.belongs_to :order
      t.integer :quantity
      t.timestamps
      t.datetime :deleted_at
    end

    drop_table :sale_variant_promotions do |t|
      t.integer :type
      t.belongs_to :sale_variant
      t.timestamps
      t.datetime :deleted_at
      t.integer :amount_cents, default: 0, null: false
      t.string :amount_currency, default: 'EUR', null: false
    end

    drop_table :sale_variants do |t|
      t.integer :quantity
      t.belongs_to :sale
      t.belongs_to :variant
      t.timestamps
      t.datetime :deleted_at
      t.integer :amount_cents, default: 0, null: false
      t.string :amount_currency, default: 'EUR', null: false
    end

    drop_table :shipping_variants do |t|
      t.integer :quantity
      t.belongs_to :shipping
      t.belongs_to :variant
      t.timestamps
      t.datetime :deleted_at
    end

    drop_table :variant_attributes do |t|
      t.string :value
      t.belongs_to :variant
      t.belongs_to :custom_attribute
      t.timestamps
      t.datetime :deleted_at
    end

    drop_table :variants do |t|
      t.string :original_barcode
      t.string :barcode
      t.float :ratio, default: 0.0
      t.integer :quantity, default: 0
      t.boolean :default
      t.belongs_to :product
      t.belongs_to :provider
      t.timestamps
      t.datetime :deleted_at
      t.integer :buying_amount_cents, default: 0, null: false
      t.string :buying_amount_currency, default: 'EUR', null: false
      t.integer :tax_free_amount_cents, default: 0, null: false
      t.string :tax_free_amount_currency, default: 'EUR', null: false
    end
  end
end
