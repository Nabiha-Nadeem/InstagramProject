require 'rails_helper'

RSpec.describe "pages/edit", type: :view do
  before(:each) do
    @page = assign(:page, Page.create!(
      name: "MyString",
      bio: "MyString",
      role: ""
    ))
  end

  it "renders the edit page form" do
    render

    assert_select "form[action=?][method=?]", page_path(@page), "post" do

      assert_select "input[name=?]", "page[name]"

      assert_select "input[name=?]", "page[bio]"

      assert_select "input[name=?]", "page[role]"
    end
  end
end
