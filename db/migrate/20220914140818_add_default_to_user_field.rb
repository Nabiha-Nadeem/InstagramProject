class AddDefaultToUserField < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :subscribed, false
  end
end
