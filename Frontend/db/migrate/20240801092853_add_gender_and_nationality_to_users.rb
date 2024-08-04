class AddGenderAndNationalityToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :gender, :string
    add_column :users, :nationality, :string
  end
end
