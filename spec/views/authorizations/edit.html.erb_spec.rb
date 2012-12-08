require 'spec_helper'

describe "authorizations/edit" do
  before(:each) do
    @authorization = assign(:authorization, stub_model(Authorization,
      :provider => "MyString",
      :user_id => 1,
      :access_token => "MyString"
    ))
  end

  it "renders the edit authorization form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => authorizations_path(@authorization), :method => "post" do
      assert_select "input#authorization_provider", :name => "authorization[provider]"
      assert_select "input#authorization_user_id", :name => "authorization[user_id]"
      assert_select "input#authorization_access_token", :name => "authorization[access_token]"
    end
  end
end
