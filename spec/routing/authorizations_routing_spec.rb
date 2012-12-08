require "spec_helper"

describe AuthorizationsController do
  describe "routing" do

    it "routes to #index" do
      get("/authorizations").should route_to("authorizations#index")
    end

    it "routes to #new" do
      get("/authorizations/new").should route_to("authorizations#new")
    end

    it "routes to #show" do
      get("/authorizations/1").should route_to("authorizations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/authorizations/1/edit").should route_to("authorizations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/authorizations").should route_to("authorizations#create")
    end

    it "routes to #update" do
      put("/authorizations/1").should route_to("authorizations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/authorizations/1").should route_to("authorizations#destroy", :id => "1")
    end

  end
end
