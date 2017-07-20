class PollQuestion < ApplicationRecord
	belongs_to :poll
	has_many :answers, class_name: "PollQuestionAnswer", dependent: :destroy

	has_many :results, dependent: :destroy
end
