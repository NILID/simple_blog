require 'rails_helper'

RSpec.describe "containers/edit", type: :view do
  before(:each) do
    @container = build(:container)
  end

  it "renders the edit container form" do
    render

    assert_select "form[action=?][method=?]", container_path(@container), "post" do

      assert_select "textarea#container_content[name=?]", "container[content]"

      assert_select "input#container_note_id[name=?]", "container[note_id]"

      assert_select "input#container_types_mask[name=?]", "container[types_mask]"
    end
  end
end
