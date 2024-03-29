# frozen_string_literal: true

# to add full name column
class AddFullnameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :fullname, :string
  end
end
