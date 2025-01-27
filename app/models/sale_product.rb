class SaleProduct < ApplicationRecord
  belongs_to :sale
  belongs_to :product
end
