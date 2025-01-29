# frozen_string_literal: true

require 'acceptance_helper'

resource 'Authentication' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  let(:user) { create(:user, confirmed_at: Time.zone.now) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id) }
  let(:token) { access_token.token }
  let(:authorization) { "Bearer #{token}" }

  route '/oauth/token', 'Authentication' do
    post 'Request auth token' do
      with_options with_example: true, required: true do
        parameter :grant_type, 'Grant type'
        parameter :username, "User's email"
        parameter :password, "User's password"
      end

      let(:grant_type) { 'password' }
      let(:username) { user.email }
      let(:password) { user.password }

      example_request 'Sign in user' do
        expect(response_status).to eq(200)
        response = JSON.parse(response_body)
        expect(response['token_type']).to eq('Bearer')
      end
    end
  end

  route '/oauth/revoke', 'Authentication' do
    header 'Authorization', :authorization

    post 'Revoke auth token' do
      parameter :token, 'Token to revoke', required: true, with_example: true

      example_request 'Revoke token' do
        expect(response_status).to eq(200)
        expect(access_token.reload.revoked?).to be(true)
      end
    end
  end

  route '/v2/current_user', 'Current User' do
    header 'Authorization', :authorization

    patch 'Update user' do
      with_options scope: :user, with_example: true do
        parameter :email, 'User new email'
        parameter :password, 'User new password'
        parameter :firstname, 'User new firstname'
        parameter :lastname, 'User new lastname'
        parameter :locale, 'User new locale'
      end

      let(:new_user) { build(:user) }
      let(:firstname) { new_user.firstname }
      let(:lastname) { new_user.lastname }
      let(:email) { new_user.email }
      let(:password) { new_user.password }

      example_request 'Update user' do
        expect(response_status).to eq(200)
        response = JSON.parse(response_body)
        expect(response['lastname']).to eq(lastname)
        expect(user.reload.lastname).to eq(lastname)
      end
    end
  end
end
