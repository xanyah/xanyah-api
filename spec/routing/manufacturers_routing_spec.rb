require "rails_helper"

RSpec.describe ManufacturersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/manufacturers").to route_to("manufacturers#index")
    end


    it "routes to #show" do
      expect(:get => "/manufacturers/1").to route_to("manufacturers#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/manufacturers").to route_to("manufacturers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/manufacturers/1").to route_to("manufacturers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/manufacturers/1").to route_to("manufacturers#update", :id => "1")
    end
  end
end
