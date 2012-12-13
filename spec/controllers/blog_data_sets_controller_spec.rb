require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe BlogDataSetsController do

  # This should return the minimal set of attributes required to create a valid
  # BlogDataSet. As you add validations to BlogDataSet, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BlogDataSetsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all blog_data_sets as @blog_data_sets" do
      blog_data_set = BlogDataSet.create! valid_attributes
      get :index, {}, valid_session
      assigns(:blog_data_sets).should eq([blog_data_set])
    end
  end

  describe "GET show" do
    it "assigns the requested blog_data_set as @blog_data_set" do
      blog_data_set = BlogDataSet.create! valid_attributes
      get :show, {:id => blog_data_set.to_param}, valid_session
      assigns(:blog_data_set).should eq(blog_data_set)
    end
  end

  describe "GET new" do
    it "assigns a new blog_data_set as @blog_data_set" do
      get :new, {}, valid_session
      assigns(:blog_data_set).should be_a_new(BlogDataSet)
    end
  end

  describe "GET edit" do
    it "assigns the requested blog_data_set as @blog_data_set" do
      blog_data_set = BlogDataSet.create! valid_attributes
      get :edit, {:id => blog_data_set.to_param}, valid_session
      assigns(:blog_data_set).should eq(blog_data_set)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new BlogDataSet" do
        expect {
          post :create, {:blog_data_set => valid_attributes}, valid_session
        }.to change(BlogDataSet, :count).by(1)
      end

      it "assigns a newly created blog_data_set as @blog_data_set" do
        post :create, {:blog_data_set => valid_attributes}, valid_session
        assigns(:blog_data_set).should be_a(BlogDataSet)
        assigns(:blog_data_set).should be_persisted
      end

      it "redirects to the created blog_data_set" do
        post :create, {:blog_data_set => valid_attributes}, valid_session
        response.should redirect_to(BlogDataSet.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved blog_data_set as @blog_data_set" do
        # Trigger the behavior that occurs when invalid params are submitted
        BlogDataSet.any_instance.stub(:save).and_return(false)
        post :create, {:blog_data_set => {}}, valid_session
        assigns(:blog_data_set).should be_a_new(BlogDataSet)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        BlogDataSet.any_instance.stub(:save).and_return(false)
        post :create, {:blog_data_set => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested blog_data_set" do
        blog_data_set = BlogDataSet.create! valid_attributes
        # Assuming there are no other blog_data_sets in the database, this
        # specifies that the BlogDataSet created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        BlogDataSet.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => blog_data_set.to_param, :blog_data_set => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested blog_data_set as @blog_data_set" do
        blog_data_set = BlogDataSet.create! valid_attributes
        put :update, {:id => blog_data_set.to_param, :blog_data_set => valid_attributes}, valid_session
        assigns(:blog_data_set).should eq(blog_data_set)
      end

      it "redirects to the blog_data_set" do
        blog_data_set = BlogDataSet.create! valid_attributes
        put :update, {:id => blog_data_set.to_param, :blog_data_set => valid_attributes}, valid_session
        response.should redirect_to(blog_data_set)
      end
    end

    describe "with invalid params" do
      it "assigns the blog_data_set as @blog_data_set" do
        blog_data_set = BlogDataSet.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        BlogDataSet.any_instance.stub(:save).and_return(false)
        put :update, {:id => blog_data_set.to_param, :blog_data_set => {}}, valid_session
        assigns(:blog_data_set).should eq(blog_data_set)
      end

      it "re-renders the 'edit' template" do
        blog_data_set = BlogDataSet.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        BlogDataSet.any_instance.stub(:save).and_return(false)
        put :update, {:id => blog_data_set.to_param, :blog_data_set => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested blog_data_set" do
      blog_data_set = BlogDataSet.create! valid_attributes
      expect {
        delete :destroy, {:id => blog_data_set.to_param}, valid_session
      }.to change(BlogDataSet, :count).by(-1)
    end

    it "redirects to the blog_data_sets list" do
      blog_data_set = BlogDataSet.create! valid_attributes
      delete :destroy, {:id => blog_data_set.to_param}, valid_session
      response.should redirect_to(blog_data_sets_url)
    end
  end

end
