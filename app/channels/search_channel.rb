class SearchChannel < ApplicationCable::Channel
  def subscribed
    stream_from "search_#{params[:search_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
