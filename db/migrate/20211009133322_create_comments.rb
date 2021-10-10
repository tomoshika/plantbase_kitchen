class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      
      t.integer :user_id
      t.integer :recipe_id
      t.text :recipe_comment

      t.timestamps
    end
  end
end
