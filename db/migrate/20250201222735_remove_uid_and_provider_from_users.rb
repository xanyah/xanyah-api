# frozen_string_literal: true

class RemoveUidAndProviderFromUsers < ActiveRecord::Migration[8.0]
  def change
    change_table :users, bulk: true do |t|
      t.remove :provider, type: :string, default: 'email', null: false
      t.remove :uid, type: :string, default: '', null: false
    end
  end
end
