# frozen_string_literal: true

class ChangeOrderStatusToState < ActiveRecord::Migration[8.0]
  def change
    change_table :orders, bulk: true do |t|
      t.remove :status, type: :integer, default: 0
      t.string :state
      t.datetime :ordered_at
      t.datetime :delivered_at
      t.datetime :withdrawn_at
      t.datetime :cancelled_at
    end
  end
end
