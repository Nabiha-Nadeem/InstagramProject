# frozen_string_literal: true

# to add some columns
class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :is_private, :boolean
  end
end
