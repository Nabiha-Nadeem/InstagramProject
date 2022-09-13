require 'rails_helper'

RSpec.describe "pages/index", type: :view do
  before(:each) do
    assign(:pages, [
      Page.create!(
        name: "Name",
        bio: "Bio",
        role: ""
      ),
      Page.create!(
        name: "Name",
        bio: "Bio",
        role: ""
      )
    ])
  end

  it "renders a list of pages" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Bio".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
  end
end
