require 'rails_helper'

RSpec.describe "StoreMemberships", type: :request do
  describe "GET /store_memberships" do
    it "works! (now write some real specs)" do
      get store_memberships_path
      expect(response).to have_http_status(200)
    end
  end
end
