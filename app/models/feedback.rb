class Feedback < ActiveRecord::Base
	belongs_to :user

	validates :report, presence: true
end
