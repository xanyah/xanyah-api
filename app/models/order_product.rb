class OrderProduct < ApplicationRecord
  belongs_to :product, optional: false
  belongs_to :order, optional: false
  has_one :store, through: :order

  validates :product_id, uniqueness: { scope: :order_id }
end
