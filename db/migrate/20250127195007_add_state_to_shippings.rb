# frozen_string_literal: true

class AddStateToShippings < ActiveRecord::Migration[8.0]
  def change
    add_column :shippings, :state, :string
    add_column :shippings, :cancelled_at, :datetime
    rename_column :shippings, :locked_at, :validated_at
  end
end
