class PollResult < ApplicationRecord
	belongs_to :poll
	belongs_to :question, class_name: "PollQuestion"
	belongs_to :answer, class_name: "PollQuestionAnswer"
	belongs_to :user
end
