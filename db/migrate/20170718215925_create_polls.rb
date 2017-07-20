class CreatePolls < ActiveRecord::Migration[5.1]
  def change
    create_table :polls do |t|
      t.string :title

      t.timestamps

      t.references :author, foreign_key: {to_table: :users}
    end

  end
end
