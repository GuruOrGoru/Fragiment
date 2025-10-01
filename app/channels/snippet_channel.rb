class SnippetChannel < ApplicationCable::Channel
  def subscribed
    stream_from "snippet_#{params[:snippet_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
