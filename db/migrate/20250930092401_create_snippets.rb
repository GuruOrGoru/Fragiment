class CreateSnippets < ActiveRecord::Migration[8.0]
  def change
    create_table :snippets do |t|
      t.string :title
      t.text :code
      t.string :language
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
