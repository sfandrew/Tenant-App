require 'rails_helper'

RSpec.describe "feedbacks/edit", type: :view do
  before(:each) do
    @feedback = assign(:feedback, Feedback.create!(
      :user_id => 1,
      :report => "MyText"
    ))
  end

  it "renders the edit feedback form" do
    render

    assert_select "form[action=?][method=?]", feedback_path(@feedback), "post" do

      assert_select "input#feedback_user_id[name=?]", "feedback[user_id]"

      assert_select "textarea#feedback_report[name=?]", "feedback[report]"
    end
  end
end
