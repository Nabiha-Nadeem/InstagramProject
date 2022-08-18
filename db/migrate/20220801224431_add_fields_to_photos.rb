# frozen_string_literal: true

# to make photos polymorphic to be used by stories as well as posts module
class AddFieldsToPhotos < ActiveRecord::Migration[5.2]
  def change
    change_table :photos do |t|
      t.references :imageable, polymorphic: true
    end
  end
end
