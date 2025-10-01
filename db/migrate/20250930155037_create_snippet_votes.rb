class CreateSnippetVotes < ActiveRecord::Migration[8.0]
  def change
    create_table :snippet_votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :snippet, null: false, foreign_key: true
      t.string :vote_type

      t.timestamps
    end
  end
end
