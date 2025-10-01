class SuggestionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @snippet = Snippet.find(params[:snippet_id])
    @suggestion = @snippet.suggestions.build(suggestion_params)
    @suggestion.user = current_user
    if @suggestion.save
      respond_to do |format|
        format.html { redirect_to @snippet, notice: "Suggestion was successfully created." }
        format.js
      end
    else
      respond_to do |format|
        format.html {
          @suggestions = @snippet.suggestions.where(response_to_id: nil).includes(:user, responses: :user).order(created_at: :desc)
          render "snippets/show"
        }
        format.js { render js: "alert('Suggestion could not be saved.');" }
      end
    end
  end

  def destroy
    @suggestion = Suggestion.find(params[:id])
    @snippet = @suggestion.snippet
    if @suggestion.user == current_user
      @suggestion.destroy
      respond_to do |format|
        format.html { redirect_to @snippet, notice: "Suggestion was successfully destroyed." }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to @snippet, alert: "You can only delete your own suggestions." }
        format.js { render js: "alert('You can only delete your own suggestions.');" }
      end
    end
  end

  private

  def suggestion_params
    params.require(:suggestion).permit(:content, :suggestion_type, :response_to_id)
  end
end
