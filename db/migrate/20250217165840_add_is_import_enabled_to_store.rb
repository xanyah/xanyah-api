# frozen_string_literal: true

class AddIsImportEnabledToStore < ActiveRecord::Migration[8.0]
  def change
    add_column :stores, :is_import_enabled, :boolean, default: false
  end
end
