class ChangeNullUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :email, true
    change_column_null :users, :encrypted_password, true
  end
end
