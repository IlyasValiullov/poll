class CreatePollQuestionAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :poll_question_answers do |t|
      t.string :answer

      t.timestamps
      t.references :question, foreign_key: {to_table: :poll_questions}
    end
  end
end
