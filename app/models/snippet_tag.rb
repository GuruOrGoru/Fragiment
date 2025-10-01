class SnippetTag < ApplicationRecord
  belongs_to :snippet
  belongs_to :tag

  validates :snippet_id, uniqueness: { scope: :tag_id }
end
