# frozen_string_literal: true

# to add bio column
class AddBioToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bio, :text
  end
end
