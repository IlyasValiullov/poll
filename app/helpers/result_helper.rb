module ResultHelper
	class ResultStatistic
		def self.get(poll_id)
			sql_query = 
	    "SELECT 
				poll.*,
				count(poll_results.user_id) as answer_count
			FROM
				(
				SELECT
					poll_questions.id as question_id, 
					poll_questions.question as question, 
					poll_questions.poll_id as poll_id,
					polls.title as poll_title,
					poll_question_answers.answer as answer,
					poll_question_answers.id as answer_id,
					count(coalesce(poll_all_results.user_id,0)) as all_answer_count
				FROM
					public.poll_questions
					INNER JOIN public.poll_question_answers AS poll_question_answers on
						poll_questions.id = poll_question_answers.question_id 
					INNER JOIN public.polls on
						polls.id = poll_questions.poll_id 
					LEFT OUTER JOIN public.poll_results AS poll_all_results ON
						poll_questions.id = poll_all_results.question_id
				WHERE
					poll_questions.poll_id = #{poll_id}
				GROUP BY
					poll_questions.id,
					poll_questions.question,
					poll_questions.poll_id,
					polls.title,
					poll_question_answers.answer,
					poll_question_answers.id    
				) as poll
			
			LEFT JOIN public.poll_results AS poll_results ON
				poll.question_id = poll_results.question_id AND 
				poll.answer_id = poll_results.answer_id



			GROUP BY
				poll.question_id,
				poll.question,
				poll.poll_id,
				poll.poll_title,
				poll.answer,
				poll.answer_id,
				poll.all_answer_count

			ORDER BY
				poll.poll_id,
				poll.question_id,
				poll.answer_id"

			ActiveRecord::Base.connection.execute(sql_query)
		end
	end

end