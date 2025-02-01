# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         # :validatable,
         # :confirmable,
         :lockable

  #  rubocop:disable Rails/InverseOf
  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all
  #  rubocop:enable Rails/InverseOf

  has_many :store_memberships, dependent: :destroy
  has_many :stores, through: :store_memberships
  has_many :sales, dependent: :nullify

  validates :email,
            presence: true,
            uniqueness: true

  def token_validation_response
    as_json(except: %i[
              tokens created_at updated_at
            ])
  end

  def tokens_has_json_column_type?
    database_exists? && table_exists? && type_for_attribute('tokens').type.in?(%i[json jsonb])
  end

  def store_admin?(store)
    store_memberships.where(store_id: store.id, role: %i[admin owner]).any?
  end

  def store_owner?(store)
    store_memberships.where(store_id: store.id, role: :owner).any?
  end

  def store_user?(store)
    store_memberships.where(store_id: store.id).any?
  end
end
