class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookmarks = current_user.bookmarks.includes(snippet: [ :user, :tags, :images_attachments, :images_blobs, :video_attachment, :video_blob ]).order(created_at: :desc)
  end

  def create
    @snippet = Snippet.find(params[:snippet_id])
    @bookmark = current_user.bookmarks.build(snippet: @snippet)

    if @bookmark.save
      respond_to do |format|
        format.html { redirect_to @snippet, notice: "Snippet bookmarked!" }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to @snippet, alert: "Unable to bookmark snippet." }
        format.js { render js: "alert('Unable to bookmark snippet.');" }
      end
    end
  end

  def destroy
    @bookmark = current_user.bookmarks.find_by(snippet_id: params[:snippet_id])
    @snippet = @bookmark.snippet

    if @bookmark.destroy
      respond_to do |format|
        format.html { redirect_to @snippet, notice: "Bookmark removed!" }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to @snippet, alert: "Unable to remove bookmark." }
        format.js { render js: "alert('Unable to remove bookmark.');" }
      end
    end
  end
end
