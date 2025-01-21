class MigratePricesToMoney < ActiveRecord::Migration[8.0]
  TABLES_TO_MIGRATE = {
    sale_payments: [
      %i[total total_amount]
    ],
    sale_promotions: [
      %i[amount amount]
    ],
    sale_variant_promotions: [
      %i[amount amount]
    ],
    sale_variants: [
      %i[unit_price amount]
    ],
    sales: [
      %i[total_price total_amount]
    ],
    variants: [
      %i[buying_price buying_amount],
      %i[tax_free_price tax_free_amount]
    ]
  }

  def migrate_table_column(table_name, original_column_name, target_column_name)
    add_monetize table_name, target_column_name

    reversible do |direction|
      direction.up do
        execute "UPDATE #{table_name} SET #{target_column_name}_cents = COALESCE(#{original_column_name}, 0) * 100, #{target_column_name}_currency = 'eur'"
      end

      direction.down do
        execute "UPDATE #{table_name} SET #{original_column_name} = #{target_column_name}_cents / 100"
      end
    end

    remove_column table_name, original_column_name, :float
  end

  def change
    TABLES_TO_MIGRATE.each do |table_name, fields_to_migrate|
      fields_to_migrate.each do |original_column_name, target_column_name|
        migrate_table_column(table_name, original_column_name, target_column_name)
      end
    end
  end
end
