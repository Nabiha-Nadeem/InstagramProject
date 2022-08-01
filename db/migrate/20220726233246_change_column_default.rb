# frozen_string_literal: true

# to add default values in columns of user table
class ChangeColumnDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :fullname, 'nil'
    change_column_default :users, :is_private, false
  end
end
