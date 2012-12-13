require 'spec_helper'

describe "blog_data_sets/index" do
  before(:each) do
    assign(:blog_data_sets, [
      stub_model(BlogDataSet,
        :post_id => 1,
        :followers => 2
      ),
      stub_model(BlogDataSet,
        :post_id => 1,
        :followers => 2
      )
    ])
  end

  it "renders a list of blog_data_sets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
