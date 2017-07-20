require 'rails_helper'

RSpec.describe "polls/new", type: :view do
  before(:each) do
    assign(:poll, Poll.new(
      :name => "MyString"
    ))
  end

  it "renders new poll form" do
    render

    assert_select "form[action=?][method=?]", polls_path, "post" do

      assert_select "input[name=?]", "poll[name]"
    end
  end
end
