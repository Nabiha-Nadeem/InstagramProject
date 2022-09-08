class ChangeLikesTable < ActiveRecord::Migration[5.2]
  def change
    change_table :likes do |t|
      t.references :likeable, polymorphic: true
    end
    remove_column :likes, :post_id, :int
  end
end
