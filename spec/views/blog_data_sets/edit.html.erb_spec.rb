require 'spec_helper'

describe "blog_data_sets/edit" do
  before(:each) do
    @blog_data_set = assign(:blog_data_set, stub_model(BlogDataSet,
      :post_id => 1,
      :followers => 1
    ))
  end

  it "renders the edit blog_data_set form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => blog_data_sets_path(@blog_data_set), :method => "post" do
      assert_select "input#blog_data_set_post_id", :name => "blog_data_set[post_id]"
      assert_select "input#blog_data_set_followers", :name => "blog_data_set[followers]"
    end
  end
end
