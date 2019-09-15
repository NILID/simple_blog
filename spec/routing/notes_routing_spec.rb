require "rails_helper"

RSpec.describe NotesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/blog").to route_to("notes#index")
    end

    it "routes to #new" do
      expect(:get => "/blog/new").to route_to("notes#new")
    end

    it "routes to #show" do
      expect(:get => "/blog/1").to route_to("notes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/blog/1/edit").to route_to("notes#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/blog").to route_to("notes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/blog/1").to route_to("notes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/blog/1").to route_to("notes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/blog/1").to route_to("notes#destroy", :id => "1")
    end
  end
end
