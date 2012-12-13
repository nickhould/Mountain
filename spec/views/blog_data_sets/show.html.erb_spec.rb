require 'spec_helper'

describe "blog_data_sets/show" do
  before(:each) do
    @blog_data_set = assign(:blog_data_set, stub_model(BlogDataSet,
      :post_id => 1,
      :followers => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
