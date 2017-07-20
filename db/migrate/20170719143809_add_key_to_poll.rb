class AddKeyToPoll < ActiveRecord::Migration[5.1]
  def change
    add_column :polls, :key, :string
  end
end
