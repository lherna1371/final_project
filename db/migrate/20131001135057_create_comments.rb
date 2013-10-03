class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.integer :user_id
    	t.integer :dish_id
    	t.text :content
    	t.integer :rating

    	t.timestamps
    end
  end
end
