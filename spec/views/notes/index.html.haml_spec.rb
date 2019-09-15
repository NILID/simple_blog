require 'rails_helper'

RSpec.describe "notes/index", type: :view do
  before(:each) do
    @note = create_list(:note, 2, :with_preview)
  end

  it "renders a list of notes" do
    render
    assert_select "article>.note-title", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
