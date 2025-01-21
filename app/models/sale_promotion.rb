# frozen_string_literal: true

class SalePromotion < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :sale
  monetize :amount_cents

  enum :type, { flat_discount: 0, percent_discount: 1 }
end
