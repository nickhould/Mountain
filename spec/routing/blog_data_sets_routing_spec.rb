require "spec_helper"

describe BlogDataSetsController do
  describe "routing" do

    it "routes to #index" do
      get("/blog_data_sets").should route_to("blog_data_sets#index")
    end

    it "routes to #new" do
      get("/blog_data_sets/new").should route_to("blog_data_sets#new")
    end

    it "routes to #show" do
      get("/blog_data_sets/1").should route_to("blog_data_sets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/blog_data_sets/1/edit").should route_to("blog_data_sets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/blog_data_sets").should route_to("blog_data_sets#create")
    end

    it "routes to #update" do
      put("/blog_data_sets/1").should route_to("blog_data_sets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/blog_data_sets/1").should route_to("blog_data_sets#destroy", :id => "1")
    end

  end
end
