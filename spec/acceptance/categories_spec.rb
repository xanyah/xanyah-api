require 'acceptance_helper'

 resource 'Categories' do
   header "Accept", "application/json"
   header "Content-Type", "application/json"
   header "Access-Token", :access_token
   header "Token-Type", :token_type
   header "Client", :client_id
   header "Expiry", :expiry
   header "Uid", :uid

   let(:membership) { create(:store_membership, role: :admin) }
   let(:auth_token) { membership.user.create_new_auth_token }
   let(:access_token) { auth_token['access-token'] }
   let(:token_type) { auth_token['token-type'] }
   let(:client_id) { auth_token['client'] }
   let(:expiry) { auth_token['expiry'] }
   let(:uid) { auth_token['uid'] }

   route '/categories', 'Categories collection' do
     get 'Returns all categories' do
       before do
         create(:category)
         create(:category, store: membership.store)
       end

       example_request "List all categories" do
         expect(response_status).to eq(200)
         expect(JSON.parse(response_body).size).to eq(1)
       end
     end

     post 'Create a category' do
       with_options scope: :category do
         parameter :label, "Category's label", required: true
         parameter :tva, "Category's TVA rate", required: true
         parameter :store_id, "Category's store id", required: true
       end

       let(:label) { category[:label] }
       let(:tva) { category[:tva] }
       let(:store_id) { membership.store_id }
       let(:category) { attributes_for(:category) }

       example_request "Create a category" do
         expect(response_status).to eq(201)
         expect(JSON.parse(response_body)['id']).to be_present
       end
     end
   end

   route '/categories/:id', 'Single category' do
     let!(:category) { create(:category, store: membership.store) }

     with_options scope: :category do
       parameter :label, "Category's name", required: true
       parameter :tva, "Category's TVA rate", required: true
     end

     get 'Get a specific category' do
       let(:id) { category.id }

       example_request 'Getting a category' do
         expect(status).to eq(200)
         body = JSON.parse(response_body)
         expect(body['id']).to eq(id)
         expect(body['label']).to eq(category.label)
       end
     end

     patch 'Update a specific category' do
       let(:id) { category.id }
       let(:label) { build(:category).label }

       example_request 'Updating a category' do
         expect(status).to eq(200)
         body = JSON.parse(response_body)
         expect(body['id']).to eq(id)
         expect(body['label']).to eq(label)
       end
     end
   end
 end
