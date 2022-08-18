# frozen_string_literal: true

# change default value of name
class ChangeDefaultFullname < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :fullname, ''
  end
end
