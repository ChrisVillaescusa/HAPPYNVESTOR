
class SearchesController < ApplicationController
  before_action :find_search, :only => [:show, :destroy]

  def index
    @searches = Search.where(user: current_user)
  end

  def show
    @results = Result.where.not(latitude: nil, longitude: nil).where(search: @search)
    @hash = Gmaps4rails.build_markers(@search) do |search, marker|
      marker.lat search.latitude
      marker.lng search.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end

  def new
  end

  def create
    @search = Search.new(search_params)
    @search.user = current_user
    if @search.save
      redirect_to @search
    else
      @types = Type.all.order(name: :asc)
      render 'pages/home'
    end
  end

  def destroy
    @search.destroy
    redirect_to searches_path
  end

  private

  def find_search
    @search = Search.find(params[:id])
  end

  def search_params
    params.require(:search).permit(:address, :type_id, :budget, :surface_min, :room_min, :radius)
  end
end
