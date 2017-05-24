class SearchesController < ApplicationController
  before_action :find_search, only: :show

  def index
    @searches = Search.all
  end

  def show
    @results = Result.where.not(latitude: nil, longitude: nil).where(search: @search)
    @hash = Gmaps4rails.build_markers(@results) do |result, marker|
      marker.lat result.latitude
      marker.lng result.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end

  def new
  end

  def create
  end

  def destroy
  end

  private

  def find_search
    @search = Search.find(params[:id])
  end
end
