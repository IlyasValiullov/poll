class CreatePollResults < ActiveRecord::Migration[5.1]
  def change
    create_table :poll_results do |t|
      t.timestamps
      t.references :poll, foreign_key: true
      t.references :user, foreign_key: true
      t.references :question, foreign_key: {to_table: :poll_questions}
      t.references :answer, foreign_key: {to_table: :poll_question_answers}
    end
  end
end
