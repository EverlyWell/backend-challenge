require "rails_helper"

RSpec.describe FriendshipsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/friendships").to route_to("friendships#index")
    end

    it "routes to #show" do
      expect(:get => "/friendships/1").to route_to("friendships#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/friendships").to route_to("friendships#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/friendships/1").to route_to("friendships#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/friendships/1").to route_to("friendships#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/friendships/1").to route_to("friendships#destroy", :id => "1")
    end
  end
end
