# frozen_string_literal: true

class SalePayment < ApplicationRecord
  belongs_to :sale
  belongs_to :payment_type

  has_one :store, through: :sale

  validate :store_validation

  protected

  def store_validation
    return unless !payment_type_id.nil? &&
                  !PaymentType.find(payment_type_id).nil? &&
                  PaymentType.find(payment_type_id).store.id != sale&.store_id

    errors.add(:payment_type, 'must belong to store')
  end
end
