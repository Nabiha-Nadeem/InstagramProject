class ChangeNullValue < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :is_private, false
    change_column_null :users, :fullname, false
  end
end
