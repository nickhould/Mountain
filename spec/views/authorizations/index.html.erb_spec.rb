require 'spec_helper'

describe "authorizations/index" do
  before(:each) do
    assign(:authorizations, [
      stub_model(Authorization,
        :provider => "Provider",
        :user_id => 1,
        :access_token => "Access Token"
      ),
      stub_model(Authorization,
        :provider => "Provider",
        :user_id => 1,
        :access_token => "Access Token"
      )
    ])
  end

  it "renders a list of authorizations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Provider".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Access Token".to_s, :count => 2
  end
end
