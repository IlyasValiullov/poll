class PollQuestion < ApplicationRecord
	belongs_to :poll
	has_many :answers, class_name: "PollQuestionAnswer", dependent: :destroy, foreign_key: "question_id"

	has_many :results, class_name: "PollResult" , foreign_key: "question_id", dependent: :destroy

	validates :question, presence: true

end
