class SnippetVote < ApplicationRecord
  belongs_to :user
  belongs_to :snippet

  validates :user_id, uniqueness: { scope: :snippet_id }

  enum :vote_type, working: "working", broken: "broken"
end
