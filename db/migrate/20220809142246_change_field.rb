# frozen_string_literal: true

# to add default value to is_private
class ChangeField < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :is_private, :boolean, default: false
  end
end
