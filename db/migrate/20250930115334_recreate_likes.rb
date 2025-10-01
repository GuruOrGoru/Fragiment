class RecreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :snippet, null: false, foreign_key: true

      t.timestamps
    end

    add_index :likes, [ :user_id, :snippet_id ], unique: true
  end
end
