require 'acceptance_helper' 

resource 'Authentication' do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let(:user) { create(:user, confirmed_at: Time.now) }
  let(:auth_token) { user.create_new_auth_token }
  let(:access_token) { auth_token['access-token'] }
  let(:token_type) { auth_token['token-type'] }
  let(:client_id) { auth_token['client'] }
  let(:expiry) { auth_token['expiry'] }
  let(:uid) { auth_token['uid'] }

  route '/auth', 'Authentication' do
    post 'Sign up user' do
      parameter :email, "User's email", required: true
      parameter :password, "User's password", required: true
      parameter :password_confirmation, "User's password confirmation", required: true
      parameter :confirm_success_url, "URL to redirect to on email confirmation", required: true

      let(:user) { build(:user) }
      let(:email) { user.email }
      let(:password) { user.password }
      let(:password_confirmation) { user.password }
      let(:confirm_success_url) { Faker::Internet.url }

      example_request "Sign up user" do
        expect(response_status).to eq(200)
        response = JSON.parse(response_body)
        expect(response['status']).to eq('success')
      end
    end

    delete 'Delete current user' do
      header "Access-Token", :access_token
      header "Token-Type", :token_type
      header "Client", :client_id
      header "Expiry", :expiry
      header "Uid", :uid

      example_request "Delete current user" do
        expect(response_status).to eq(200)
      end
    end

    patch 'Update current user' do
      header "Access-Token", :access_token
      header "Token-Type", :token_type
      header "Client", :client_id
      header "Expiry", :expiry
      header "Uid", :uid

      parameter :password, "User's new password", required: true
      parameter :password_confirmation, "User's new password confirmation", required: true

      let(:user) { build(:user) }
      let(:password) { user.password }
      let(:password_confirmation) { user.password }

      example_request "Update current user" do
        expect(response_status).to eq(200)
      end
    end
  end

  route 'auth/sign_in', 'User session' do
    post 'Sign in user' do
      parameter :email, "User's email", required: true
      parameter :password, "User's password", required: true

      let(:email) { user.email }
      let(:password) { user.password }

      example_request "Sign in user" do
        expect(response_status).to eq(200)
        expect(response_headers['uid']).to be_present
        expect(response_headers['access-token']).to be_present
        expect(response_headers['client']).to be_present
        expect(response_headers['expiry']).to be_present
      end
    end
  end

  route 'auth/sign_out', 'User session' do
    delete 'Sign out user' do
      header "Access-Token", :access_token
      header "Token-Type", :token_type
      header "Client", :client_id
      header "Expiry", :expiry
      header "Uid", :uid

      example_request "Sign out user" do
        expect(response_status).to eq(200)
        expect(response_headers['uid']).not_to be_present
        expect(response_headers['access-token']).not_to be_present
        expect(response_headers['client']).not_to be_present
        expect(response_headers['expiry']).not_to be_present
      end
    end
  end

  route 'auth/validate_token', 'User session' do
    get 'Validate user session' do
      header "Access-Token", :access_token
      header "Token-Type", :token_type
      header "Client", :client_id
      header "Expiry", :expiry
      header "Uid", :uid

      example_request "Validate user session" do
        expect(response_status).to eq(200)
      end
    end
  end

  route 'auth/password', 'User password' do
    post 'Request password reset email' do
      parameter :email, "User's email", required: true
      parameter :redirect_url, "URL to redirect to on email opening", required: true

      let(:email) { user.email }
      let(:redirect_url) { Faker::Internet.url }
    end

    patch "Update current user's password" do
      header "Access-Token", :access_token
      header "Token-Type", :token_type
      header "Client", :client_id
      header "Expiry", :expiry
      header "Uid", :uid

      parameter :password, "User's new password", required: true
      parameter :password_confirmation, "User's new password confirmation", required: true

      let(:user) { build(:user) }
      let(:password) { user.password }
      let(:password_confirmation) { user.password }

      example_request "Update current user's password" do
        expect(response_status).to eq(200)
      end
    end
  end
end
