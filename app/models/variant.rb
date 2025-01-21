# frozen_string_literal: true

class Variant < ApplicationRecord
  before_validation :set_barcode, on: :create
  before_validation :set_default, on: :create

  belongs_to :product, optional: false
  belongs_to :provider, optional: false
  has_one :category, through: :product
  has_one :vat_rate, through: :category
  has_one :store, through: :product
  has_many :variant_attributes, dependent: :destroy

  validates :barcode, presence: true
  validates :original_barcode, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :barcode_validation, on: :create

  monetize :buying_amount_cents, :tax_free_amount_cents

  accepts_nested_attributes_for :variant_attributes, allow_destroy: true

  def vat_amount
    @vat_amount ||= tax_free_amount * (vat_rate&.rate_percent_cents.to_i / (100 * 100))
  end

  def vat_amount_cents
    @vat_amount_cents ||= vat_amount.fractional
  end

  def vat_amount_currency
    @vat_amount_currency ||= vat_amount.currency.iso_code
  end

  def amount
    @amount ||= tax_free_amount + vat_price
  end

  def amount_cents
    @amount_cents ||= amount.fractional
  end

  def amount_currency
    @amount_currency ||= amount.currency.iso_code
  end

  def self.search(query)
    query = query.downcase
    joins(:product).where("
      barcode LIKE ?
      OR original_barcode LIKE ?
      OR LOWER(products.name) LIKE ?
    ", "%#{query}", "%#{query}", "%#{query}%")
  end

  protected

  def barcode_validation
    errors.add(:barcode, 'must be uniq') unless store.nil? || store.variants.find_by(barcode: barcode).nil?
  end

  def set_barcode # rubocop:disable Metrics/AbcSize
    return nil if product.nil? || original_barcode.nil?
    return self.barcode = original_barcode if store&.variants&.find_by(barcode: original_barcode).nil?

    value = 0
    loop do
      self.barcode = "#{product.variants.size.to_s.rjust(5, value.to_s)}#{original_barcode.gsub(/^0+/, '')}"
      value += 1
      break if store.variants.find_by(barcode: barcode).nil?
    end
  end

  def set_default
    self.default = product.variants.size <= 0 unless product.nil?
  end
end
