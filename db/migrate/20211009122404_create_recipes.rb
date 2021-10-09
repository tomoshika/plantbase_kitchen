class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.integer :user_id
      t.string :title, null: false
      t.text :recipe, null: false
      t.string :image_id
      t.text :memo

      t.timestamps
    end
  end
end
