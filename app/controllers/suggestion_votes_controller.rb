class SuggestionVotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @suggestion = Suggestion.find(params[:suggestion_id])
    @vote = current_user.suggestion_votes.build(suggestion: @suggestion, vote_type: params[:vote_type] || "implemented")
    @vote.save

    respond_to do |format|
      format.html { redirect_back fallback_location: @suggestion.snippet }
      format.js
    end
  end

  def destroy
    @vote = current_user.suggestion_votes.find_by(suggestion_id: params[:suggestion_id])
    @suggestion = @vote.suggestion if @vote
    @vote&.destroy

    respond_to do |format|
      format.html { redirect_back fallback_location: @suggestion&.snippet || root_path }
      format.js
    end
  end
end
