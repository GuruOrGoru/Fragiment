class SnippetVotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @snippet = Snippet.find(params[:snippet_id])
    @vote = current_user.snippet_votes.build(snippet: @snippet, vote_type: params[:vote_type] || "working")
    @vote.save

    respond_to do |format|
      format.html { redirect_back fallback_location: @snippet }
      format.js
    end
  end

  def destroy
    @vote = current_user.snippet_votes.find_by(snippet_id: params[:snippet_id])
    @snippet = @vote.snippet if @vote
    @vote&.destroy

    respond_to do |format|
      format.html { redirect_back fallback_location: @snippet || root_path }
      format.js
    end
  end
end
