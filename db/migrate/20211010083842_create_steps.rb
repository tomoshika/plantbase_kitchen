class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
      t.integer :recipe_id, null: false 
      t.string :process, null: false
      t.string :process_image_id

      t.timestamps
    end
  end
end
