require 'acceptance_helper'

 resource 'Manufacturers' do
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

   route '/manufacturers', 'Manufacturers collection' do
     get 'Returns all manufacturers' do
       before do
         create(:manufacturer)
         create(:manufacturer, store: membership.store)
       end

       example_request "List all manufacturers" do
         expect(response_status).to eq(200)
         expect(JSON.parse(response_body).size).to eq(1)
       end
     end

     post 'Create a manufacturer' do
       with_options scope: :manufacturer do
         parameter :name, "Manufacturer's name", required: true
         parameter :notes, "Notes about manufacturer"
         parameter :store_id, "Manufacturer's store id", required: true
       end

       let(:name) { manufacturer[:name] }
       let(:notes) { manufacturer[:notes] }
       let(:store_id) { membership.store_id }
       let(:manufacturer) { attributes_for(:manufacturer) }

       example_request "Create a manufacturer" do
         expect(response_status).to eq(201)
         expect(JSON.parse(response_body)['id']).to be_present
       end
     end
   end

   route '/manufacturer/:id', 'Single manufacturer' do
     let!(:manufacturer) { create(:manufacturer, store: membership.store) }

     with_options scope: :manufacturer do
       parameter :name, "Manufacturer's name", required: true
       parameter :notes, "Notes about manufacturer"
     end

     get 'Get a specific manufacturer' do
       let(:id) { manufacturer.id }

       example_request 'Getting a manufacturer' do
         expect(status).to eq(200)
         body = JSON.parse(response_body)
         expect(body['id']).to eq(id)
         expect(body['name']).to eq(manufacturer.name)
       end
     end

     patch 'Update a specific manufacturer' do
       let(:id) { manufacturer.id }
       let(:name) { build(:manufacturer).name }

       example_request 'Updating a manufacturer' do
         expect(status).to eq(200)
         body = JSON.parse(response_body)
         expect(body['id']).to eq(id)
         expect(body['name']).to eq(name)
       end
     end
   end
 end
