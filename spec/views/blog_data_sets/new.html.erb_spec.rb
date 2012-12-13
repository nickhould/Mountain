require 'spec_helper'

describe "blog_data_sets/new" do
  before(:each) do
    assign(:blog_data_set, stub_model(BlogDataSet,
      :post_id => 1,
      :followers => 1
    ).as_new_record)
  end

  it "renders new blog_data_set form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => blog_data_sets_path, :method => "post" do
      assert_select "input#blog_data_set_post_id", :name => "blog_data_set[post_id]"
      assert_select "input#blog_data_set_followers", :name => "blog_data_set[followers]"
    end
  end
end
