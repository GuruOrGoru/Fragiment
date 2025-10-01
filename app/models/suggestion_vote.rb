class SuggestionVote < ApplicationRecord
  belongs_to :user
  belongs_to :suggestion

  validates :user_id, uniqueness: { scope: :suggestion_id }

  enum :vote_type, working: "working", broken: "broken", implemented: "implemented", not_working: "not_working"
end
