class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 100, 100 ]
  end

  has_many :snippets, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :suggestion_votes, dependent: :destroy
  has_many :snippet_votes, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_snippets, through: :bookmarks, source: :snippet

  validates :name, presence: true

  after_save :clear_user_caches
  after_destroy :clear_user_caches

  def admin?
    admin
  end

  def cached_snippet_count
    Rails.cache.fetch("user_#{id}_snippet_count", expires_in: 1.hour) do
      snippets.count
    end
  end

  def cached_suggestion_count
    Rails.cache.fetch("user_#{id}_suggestion_count", expires_in: 1.hour) do
      suggestions.count
    end
  end

  def cached_suggestion_vote_count
    Rails.cache.fetch("user_#{id}_suggestion_vote_count", expires_in: 1.hour) do
      suggestion_votes.count
    end
  end

  def clear_user_caches
    Rails.cache.delete("user_#{id}_snippet_count")
    Rails.cache.delete("user_#{id}_suggestion_count")
    Rails.cache.delete("user_#{id}_suggestion_vote_count")
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "name" ]
  end
end
