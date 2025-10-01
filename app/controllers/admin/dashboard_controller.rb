class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @total_users = User.count
    @total_snippets = Snippet.count
    @recent_snippets = Snippet.order(created_at: :desc).limit(5)
    @recent_users = User.order(created_at: :desc).limit(5)
  end

  private

  def require_admin
    redirect_to root_path, alert: "Access denied" unless current_user.admin?
  end
end
