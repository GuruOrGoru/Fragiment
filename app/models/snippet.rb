class Snippet < ApplicationRecord
  belongs_to :user

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 300, 200 ]
  end
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 300, 200 ]
  end
  has_one_attached :video

  has_many :suggestions, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :snippet_votes, dependent: :destroy
  has_many :snippet_tags, dependent: :destroy
  has_many :tags, through: :snippet_tags
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_by_users, through: :bookmarks, source: :user

  validates :title, :code, :language, presence: true

  attr_accessor :tag_list

  after_save :clear_caches
  after_destroy :clear_caches

  def clear_caches
    Rails.cache.delete("snippet_#{id}_suggestion_count")
    Rails.cache.delete("snippet_#{id}_like_count")
    Rails.cache.delete("snippet_#{id}_bookmark_count")
    Rails.cache.delete("user_#{user_id}_snippet_count")
  end

  def all_images
    if images.attached?
      images
    elsif image.attached?
      [ image ]
    else
      []
    end
  end

  def cached_suggestion_count
    Rails.cache.fetch("snippet_#{id}_suggestion_count", expires_in: 30.minutes) do
      suggestions.count
    end
  end

  def cached_like_count
    Rails.cache.fetch("snippet_#{id}_like_count", expires_in: 30.minutes) do
      likes.count
    end
  end

  def cached_bookmark_count
    Rails.cache.fetch("snippet_#{id}_bookmark_count", expires_in: 30.minutes) do
      bookmarks.count
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "code", "created_at", "description", "id", "language", "title", "updated_at", "user_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "suggestions", "image_attachment", "image_blob", "images_attachments", "images_blobs", "user", "video_attachment", "video_blob", "tags" ]
  end
end
