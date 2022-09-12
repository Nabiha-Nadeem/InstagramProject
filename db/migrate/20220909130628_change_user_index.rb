class ChangeUserIndex < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, :email
    remove_index :users, :reset_password_token
    add_index :users, :fullname
  end
end
