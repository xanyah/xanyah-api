class Inventory < ApplicationRecord
  belongs_to :store, optional: false
end
