class Store < ApplicationRecord

  has_many :admin_store_memberships, -> { admin }, class_name: 'StoreMembership'
  has_many :admins, source: :user, through: :admin_store_memberships
  has_many :backup_variants, through: :stock_backups
  has_many :categories
  has_many :custom_attributes
  has_many :inventories
  has_many :inventory_variants, through: :inventories
  has_many :manufacturers
  has_many :owner_store_memberships, -> { owner }, class_name: 'StoreMembership'
  has_many :owners, source: :user, through: :owner_store_memberships
  has_many :products
  has_many :providers
  has_many :store_memberships
  has_many :stock_backups
  has_many :stock_backup_variants, through: :stock_backups
  has_many :users, through: :store_memberships
  has_many :variants, through: :products
  has_many :variant_attributes, through: :variants

  validates :country, presence: true, inclusion: { in: ISO3166::Country.all.map(&:alpha2) }
  validates :key, presence: true, uniqueness: true, allow_nil: false
  validates :name, presence: true

  before_validation { self.country = self.country.nil? ? '' : self.country.upcase }
end
