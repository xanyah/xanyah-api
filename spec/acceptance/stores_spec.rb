require 'acceptance_helper' 

resource 'Store' do
  route '/stores', 'Stores collection' do
    get 'Returns all stores' do
      let!(:store) { create(:store) }
      example_request "List all stores" do
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end
  end
end
