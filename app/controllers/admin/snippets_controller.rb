class Admin::SnippetsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_snippet, only: [ :show, :edit, :update, :destroy ]

  def index
    @snippets = Snippet.all.includes(:user)
  end

  def show
  end

  def edit
  end

  def update
    if @snippet.update(snippet_params)
      redirect_to admin_snippet_path(@snippet), notice: "Snippet updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @snippet.destroy
    redirect_to admin_snippets_path, notice: "Snippet deleted successfully"
  end

  private

  def set_snippet
    @snippet = Snippet.find(params[:id])
  end

  def snippet_params
    params.require(:snippet).permit(:title, :code, :language, :description, :user_id, images: [], tag_list: [])
  end

  def require_admin
    redirect_to root_path, alert: "Access denied" unless current_user.admin?
  end
end
