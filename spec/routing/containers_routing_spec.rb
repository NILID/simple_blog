require "rails_helper"

RSpec.describe ContainersController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(:get => "/posts/1/containers/new").to route_to("containers#new", :post_id => '1')
    end

    it "routes to #edit" do
      expect(:get => "/posts/1/containers/1/edit").to route_to("containers#edit", :id => "1", :post_id => '1')
    end

    it "routes to #create" do
      expect(:post => "/posts/1/containers").to route_to("containers#create", :post_id => '1')
    end

    it "routes to #update via PUT" do
      expect(:put => "/posts/1/containers/1").to route_to("containers#update", :id => "1", :post_id => '1')
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/posts/1/containers/1").to route_to("containers#update", :id => "1", :post_id => '1')
    end

    it "routes to #destroy" do
      expect(:delete => "/posts/1/containers/1").to route_to("containers#destroy", :id => "1", :post_id => '1')
    end
  end
end
