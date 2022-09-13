class CreateUserPageRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :user_page_relationships do |t|
      t.integer 'user_id'
      t.integer 'page_id'
      t.integer 'role'
      t.timestamps
    end
  end
end
