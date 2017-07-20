class CreatePollQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :poll_questions do |t|
      t.string :question

      t.timestamps
      t.references :poll, foreign_key: true
    end
  end
end
