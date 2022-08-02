# frozen_string_literal: true

# to create stories
class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
