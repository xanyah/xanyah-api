# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it :has_valid_factory do
    expect(build(:user)).to be_valid
  end

  describe 'validations' do
    describe 'email' do
      it :uniqueness do
        user = create(:user)
        expect(user).to be_valid
        expect(build(:user, email: user.email)).not_to be_valid
      end

      it :presence do
        expect(build(:user, email: nil)).not_to be_valid
      end
    end
  end
end
