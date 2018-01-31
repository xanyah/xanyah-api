# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable
  include DeviseTokenAuth::Concerns::User

  has_many :store_memberships, dependent: :destroy
  has_many :stores, through: :store_memberships

  def token_validation_response
    as_json(except: %i[
              tokens created_at updated_at
            ])
  end
end
