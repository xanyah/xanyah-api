# frozen_string_literal: true

class AddDeletedAt < ActiveRecord::Migration[5.2]
  def change
    (
      ActiveRecord::Base.connection.tables -
      %w[schema_migrations ar_internal_metadata active_storage_blobs active_storage_attachments]
    ).each do |table|
      add_column table, :deleted_at, :datetime
      add_index table, :deleted_at
    end
  end
end
