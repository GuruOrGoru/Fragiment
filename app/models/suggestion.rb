class Suggestion < ApplicationRecord
  belongs_to :user
  belongs_to :snippet
  belongs_to :response_to, class_name: "Suggestion", optional: true
  has_many :responses, -> { order(created_at: :asc) }, class_name: "Suggestion", foreign_key: :response_to_id, dependent: :destroy
  has_many :suggestion_votes, dependent: :destroy

  validates :content, presence: true

  enum :suggestion_type, feature_request: "feature_request", bug_report: "bug_report", improvement: "improvement"
  enum :status, pending: "pending", working: "working", broken: "broken", implemented: "implemented", not_working: "not_working", rejected: "rejected"
end
