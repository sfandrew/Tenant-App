require 'rails_helper'

RSpec.describe "feedbacks/new", type: :view do
  before(:each) do
    assign(:feedback, Feedback.new(
      :user_id => 1,
      :report => "MyText"
    ))
  end

  it "renders new feedback form" do
    render

    assert_select "form[action=?][method=?]", feedbacks_path, "post" do

      assert_select "input#feedback_user_id[name=?]", "feedback[user_id]"

      assert_select "textarea#feedback_report[name=?]", "feedback[report]"
    end
  end
end
