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
end
