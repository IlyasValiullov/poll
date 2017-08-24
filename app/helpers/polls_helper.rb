module PollsHelper
	def generate_vote_url poll
		root_url + "vote?key=#{poll.key}"
	end

	def is_author? poll
		poll.author == current_user
	end

	def can_vote? poll
		!PollAccess.where(poll: poll, user: current_user).first.nil?
	end

	class PollInfo
		def self.show(poll_id)
			@poll_results = []
			@temp_questions = []
			@temp_answers = []
			@poll_questions = PollQuestion.select("poll_questions.poll_id, 
				poll_questions.id, 
				poll_questions.question, 
				poll_question_answers.id as answer_id, 
				poll_question_answers.answer")
			.joins("INNER JOIN poll_question_answers 
				on poll_questions.id = poll_question_answers.question_id")
			.where(poll_id: poll_id)
			answers = []

			@poll_questions.each do |quan|

				if !@temp_questions.include?(quan.id)
					@temp_questions << quan.id
					answers = []
					answers << { :answer_id => quan[:answer_id],
						:answer => quan[:answer], 
						:value => false 
					}
					@poll_results << { :poll_id =>  quan[:poll_id],
						:question_id =>  quan[:id],
						:question =>  quan[:question],
						:answers=> answers 
					}
				else
					answers << { :answer_id => quan[:answer_id],
						:answer => quan[:answer], 
						:value => false 
					}
				end
			end
		end
	end
end
