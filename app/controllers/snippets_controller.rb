class SnippetsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_snippet, only: [ :show, :edit, :update, :destroy ]

  def index
    @q = Snippet.ransack(params[:q])
    @snippets = @q.result.includes(:user).page(params[:page]).per(5)
  end



  def language
    @language = params[:language]
    @snippets = Snippet.where(language: @language).includes(:user, :tags).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @suggestion = Suggestion.new
    @suggestions = @snippet.suggestions.where(response_to_id: nil).includes(:user, responses: [ :user ]).order(created_at: :desc)
  end

  def new
    @snippet = current_user.snippets.build
  end

  def create
    log_params
    Rails.logger.info "Creating snippet with params: #{snippet_params.inspect}"
    @snippet = current_user.snippets.build(snippet_params)
    Rails.logger.info "Snippet valid? #{@snippet.valid?}"
    Rails.logger.info "Snippet errors: #{@snippet.errors.full_messages}" if @snippet.invalid?

    if @snippet.save
      assign_tags(@snippet, params[:snippet][:tag_list])
      if params[:snippet][:images].present?
        @snippet.images.attach(params[:snippet][:images].reject(&:blank?))
      end
      if params[:snippet][:video].present?
        @snippet.video.attach(params[:snippet][:video])
      end
      redirect_to @snippet, notice: "Snippet was successfully created."
    else
      Rails.logger.error "Failed to save snippet: #{@snippet.errors.full_messages}"
      render :new
    end
  rescue => e
    Rails.logger.error "Exception in create: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    @snippet = current_user.snippets.build(snippet_params)
    render :new
  end

  def edit
    authorize_user
    @snippet.tag_list = @snippet.tags.pluck(:name).join(", ")
  end

  def update
    authorize_user
    if @snippet.update(snippet_params)
      assign_tags(@snippet, params[:snippet][:tag_list])
      if params[:snippet][:images].present?
        @snippet.images.attach(params[:snippet][:images].reject(&:blank?))
      end
      if params[:snippet][:video].present?
        @snippet.video.attach(params[:snippet][:video])
      end
      redirect_to @snippet, notice: "Snippet was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize_user
    Rails.logger.info "Snippet deleted: ID #{@snippet.id} by user #{current_user.id} (#{current_user.email})"
    @snippet.destroy
    redirect_to snippets_url, notice: "Snippet was successfully destroyed."
  end

  private

  def set_snippet
    @snippet = Snippet.find(params[:id])
  end

  def snippet_params
    params.require(:snippet).permit(:title, :code, :language, :description, :images, :video, :tag_list)
  end

  private

  def log_params
    Rails.logger.info "All params: #{params.inspect}"
    Rails.logger.info "Snippet params: #{params[:snippet].inspect}" if params[:snippet]
  end

  def authorize_user
    unless @snippet.user == current_user
      redirect_to snippets_path, alert: "You can only edit or delete your own snippets."
    end
  end

  def assign_tags(snippet, tag_list)
    return unless tag_list.present?

    tag_names = tag_list.split(",").map(&:strip).reject(&:blank?).map(&:downcase).uniq
    tags = tag_names.map { |name| Tag.find_or_create_by(name: name) }
    snippet.tags = tags
  end
end
