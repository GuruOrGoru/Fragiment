class Tag < ApplicationRecord
  has_many :snippet_tags, dependent: :destroy
  has_many :snippets, through: :snippet_tags

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  before_save :downcase_name

  def self.ransackable_attributes(auth_object = nil)
    [ "name" ]
  end

  private

  def downcase_name
    self.name = name.downcase
  end
end
