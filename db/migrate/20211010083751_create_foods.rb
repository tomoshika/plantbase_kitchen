class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.integer :recipe_id, null: false
      t.string :item, null: false
      t.string :quantity, null: false

      t.timestamps
    end
  end
end
