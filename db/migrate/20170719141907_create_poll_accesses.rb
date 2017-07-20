class CreatePollAccesses < ActiveRecord::Migration[5.1]
  def change
    create_table :poll_accesses do |t|
      t.timestamps
      t.references :poll, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
