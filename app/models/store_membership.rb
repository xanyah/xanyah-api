class StoreMembership < ApplicationRecord
  enum role: %w(regular admin owner)
  validates :store, uniqueness: { scope: :user }
  belongs_to :store
  belongs_to :user

  scope :regular, -> { where(role: [:regular, :admin, :owner]) }
  scope :admin, -> { where(role: [:admin, :owner]) }
  scope :owner, -> { where(role: :owner) }
end
