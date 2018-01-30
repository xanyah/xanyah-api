class StoreMembership < ApplicationRecord
  enum role: [:regular, :admin, :owner]
  validates :store, uniqueness: { scope: :user }
  belongs_to :store, optional: false
  belongs_to :user, optional: false

  scope :regular, -> { where(role: [:regular, :admin, :owner]) }
  scope :admin, -> { where(role: [:admin, :owner]) }
  scope :owner, -> { where(role: :owner) }
end
