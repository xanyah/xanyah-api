# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShippingProduct do
  it :has_valid_factory do
    expect(build(:shipping_product)).to be_valid
  end
end
