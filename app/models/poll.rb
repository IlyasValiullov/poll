class Poll < ApplicationRecord
	belongs_to :author, class_name: "User"
	has_many :questions, class_name: "PollQuestion", dependent: :destroy

	has_many :results,class_name: "PollResult",dependent: :destroy
	has_many :poll_accesses, dependent: :destroy

	before_create :set_key

	def set_key
		self.key = SecureRandom.hex(20)
	end
end
