# frozen_string_literal: true

class RemoveProviderFromProducts < ActiveRecord::Migration[8.0]
  def change
    remove_reference :products, :provider, index: true, foreign_key: true, type: :uuid
  end
end
