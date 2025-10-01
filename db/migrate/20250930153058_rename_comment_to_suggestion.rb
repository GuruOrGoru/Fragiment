class RenameCommentToSuggestion < ActiveRecord::Migration[8.0]
  def change
    rename_table :comments, :suggestions
    rename_table :comment_likes, :suggestion_votes

    rename_column :suggestions, :parent_id, :response_to_id
    rename_column :suggestion_votes, :comment_id, :suggestion_id

    add_column :suggestions, :suggestion_type, :string, default: 'feature_request'
    add_column :suggestions, :status, :string, default: 'pending'
    add_column :suggestion_votes, :vote_type, :string, default: 'implemented'
  end
end
