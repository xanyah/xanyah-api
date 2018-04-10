# frozen_string_literal: true

class SalePayment < ApplicationRecord
  belongs_to :sale
  belongs_to :payment_type
end
