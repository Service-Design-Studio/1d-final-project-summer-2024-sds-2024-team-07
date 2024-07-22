class AddSessionIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :session_id, :string
  end
end
