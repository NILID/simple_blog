require 'rails_helper'

RSpec.describe "notes/new", type: :view do
  before(:each) do
    @note = create(:note, :with_preview)
  end

  it "renders new note form" do
    render

    assert_select "form[action=?][method=?]", notes_path, "note" do

      assert_select "input#note_title[name=?]", "note[title]"

      assert_select "textarea#note_desc[name=?]", "note[desc]"

      assert_select "input#note_preview[name=?]", "note[preview]"
    end
  end
end
