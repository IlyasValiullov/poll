class User < ApplicationRecord
  has_secure_password

	has_many :polls, dependent: :destroy, foreign_key: "author_id" 
  has_many :results, dependent: :destroy, class_name: "PollResult"

  has_many :poll_accesses, dependent: :destroy
	
  validates :email, uniqueness: true

  def accessible_polls
  	poll_accesses
  end
end
