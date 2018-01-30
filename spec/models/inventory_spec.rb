require 'rails_helper'

RSpec.describe Inventory, type: :model do
  it :has_valid_factory do
    expect(build(:inventory)).to be_valid
  end
end
