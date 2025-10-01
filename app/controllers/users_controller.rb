class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @snippets = @user.snippets.includes(:user, :images_attachments, :images_blobs, :video_attachment, :video_blob).page(params[:page]).per(10)
    if current_user&.admin?
      Rails.logger.info "Admin viewed user profile: user #{@user.id} viewed by admin #{current_user.id}"
    end
  end
end
