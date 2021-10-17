class CreateHashtagRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtag_relations do |t|
      t.references :recipe, foreign_key: true
      t.references :hashtag, foreign_key: true

      t.timestamps
    end
  end
end
