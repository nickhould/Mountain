require 'spec_helper'

describe "authorizations/show" do
  before(:each) do
    @authorization = assign(:authorization, stub_model(Authorization,
      :provider => "Provider",
      :user_id => 1,
      :access_token => "Access Token"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Provider/)
    rendered.should match(/1/)
    rendered.should match(/Access Token/)
  end
end
