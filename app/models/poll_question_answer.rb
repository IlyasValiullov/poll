class PollQuestionAnswer < ApplicationRecord
	belongs_to :question, class_name: "PollQuestion", foreign_key: "question_id"

	has_many :results, dependent: :destroy
end
