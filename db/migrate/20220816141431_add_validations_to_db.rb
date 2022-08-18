# frozen_string_literal: true

# to add null => false
class AddValidationsToDb < ActiveRecord::Migration[5.2]
  def change
    change_column_null :comments, :body, false
    change_column_null :comments, :post_id, false
    change_column_null :comments, :user_id, false

    change_column_null :follows, :user_id, false
    change_column_null :follows, :following_id, false

    change_column_null :likes, :post_id, false
    change_column_null :likes, :user_id, false

    remove_column :photos, :post_id
    change_column_null :photos, :imageable_id, false
    change_column_null :photos, :imageable_type, false
    change_column_null :photos, :image, false

    change_column_null :posts, :user_id, false

    change_column_null :requests, :user_id, false
    change_column_null :requests, :following_id, false

    change_column_null :stories, :user_id, false
  end
end
