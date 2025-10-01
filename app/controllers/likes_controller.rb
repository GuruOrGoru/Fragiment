class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @snippet = Snippet.find(params[:snippet_id])
    @like = current_user.likes.build(snippet: @snippet)

    if @like.save
      # Broadcast to Action Cable
      SnippetChannel.broadcast_to(
        @snippet,
        type: "like_update",
        snippet_id: @snippet.id,
        likes_count: @snippet.likes.count,
        action: "liked",
        user_id: current_user.id
      )

      respond_to do |format|
        format.html { redirect_to @snippet }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to @snippet, alert: "Unable to like snippet." }
        format.js { render js: "alert('Unable to like snippet.');" }
      end
    end
  end

  def destroy
    @like = current_user.likes.find_by(snippet_id: params[:snippet_id])
    @snippet = @like.snippet

    if @like.destroy
      # Broadcast to Action Cable
      SnippetChannel.broadcast_to(
        @snippet,
        type: "like_update",
        snippet_id: @snippet.id,
        likes_count: @snippet.likes.count,
        action: "unliked",
        user_id: current_user.id
      )

      respond_to do |format|
        format.html { redirect_to @snippet }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to @snippet, alert: "Unable to unlike snippet." }
        format.js { render js: "alert('Unable to unlike snippet.');" }
      end
    end
  end
end
