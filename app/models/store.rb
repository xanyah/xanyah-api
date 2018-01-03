class Store < ApplicationRecord
  has_many :store_memberships
  has_many :users, through: :store_memberships
  has_many :admin_store_memberships, -> { admin }, class_name: 'StoreMembership'
  has_many :admins, source: :user, through: :admin_store_memberships
  has_many :owner_store_memberships, -> { owner }, class_name: 'StoreMembership'
  has_many :owners, source: :user, through: :owner_store_memberships

  validates :country, presence: true
  validates :key, presence: true, uniqueness: true, allow_nil: false
  validates :name, presence: true
end
