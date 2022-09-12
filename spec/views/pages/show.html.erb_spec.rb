require 'rails_helper'

RSpec.describe "pages/show", type: :view do
  before(:each) do
    @page = assign(:page, Page.create!(
      name: "Name",
      bio: "Bio",
      role: ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Bio/)
    expect(rendered).to match(//)
  end
end
