require 'rails_helper'

RSpec.describe "polls/index", type: :view do
  before(:each) do
    assign(:polls, [
      Poll.create!(
        :name => "Name"
      ),
      Poll.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of polls" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
