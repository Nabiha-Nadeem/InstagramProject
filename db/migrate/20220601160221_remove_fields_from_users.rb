# frozen_string_literal: true

# had to remove columns which aren't required
class RemoveFieldsFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
  end
end
