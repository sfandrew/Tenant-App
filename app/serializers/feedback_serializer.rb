class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :report
end
