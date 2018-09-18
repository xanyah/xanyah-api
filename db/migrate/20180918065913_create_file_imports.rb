# frozen_string_literal: true

class CreateFileImports < ActiveRecord::Migration[5.2]
  def change
    create_table :file_imports, id: :uuid do |t|
      t.belongs_to :user, foreign_key: true, type: :uuid
      t.belongs_to :store, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
