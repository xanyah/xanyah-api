require 'rails_helper'

RSpec.describe Manufacturer, type: :model do

  it :has_valid_factory do
    expect(build(:manufacturer)).to be_valid
  end

  describe :validations do
    describe :name do
      it :presence do
        expect(build(:manufacturer, name: nil)).not_to be_valid
      end
    end

    describe :store do
      it :presence do
        expect(build(:manufacturer, store: nil)).not_to be_valid
      end
    end
  end
end
