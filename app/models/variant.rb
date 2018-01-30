class Variant < ApplicationRecord
  before_validation :set_barcode, on: :create

  belongs_to :product, optional: false
  belongs_to :provider, optional: false
  has_one :store, through: :product
  has_many :variant_attributes

  validates :barcode, presence: true
  validates :buying_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :original_barcode, presence: true
  validates :tax_free_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :barcode_validation, on: :create

  protected
  def barcode_validation
    errors.add(:barcode, 'must be uniq') unless self.store.nil? || self.store.variants.find_by(barcode: self.barcode).nil?
  end

  def set_barcode
    return nil if self.product.nil? || self.original_barcode.nil?
    value = 0
    loop do
      self.barcode = "#{self.product.variants.size.to_s.rjust(5, value.to_s)}#{self.original_barcode.gsub(/^0+/, '')}"
      value = value + 1
      break if self.store.variants.find_by(barcode: self.barcode).nil?
    end 
  end
end
