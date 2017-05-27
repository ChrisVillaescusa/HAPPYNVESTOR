module ApplicationHelper

  def render_navbar
    render 'shared/navbar' unless home
  end

  def display_static_map(search)
    # map = GoogleStaticMap.new(
    #   zoom: 12,
    #   format: 'gif',
    #   width: 400,
    #   height: 600,
    #   center: MapLocation.new(latitude: search.latitude, longitude: search.longitude),
    # )
    # map.markers << MapMarker.new(color: 'red', location: MapLocation.new(latitude: search.latitude, longitude: search.longitude))
    # map.api_key = ENV['GOOGLE_API_KEY']
    # map.url('https')
      # map.url('https')
    zoom = 12
    size = '400x600'
    URI.encode("https://maps.googleapis.com/maps/api/staticmap?center=#{@search.latitude},#{@search.longitude}&zoom=#{zoom}&size=#{size}&marquers=color:red|#{@search.latitude},#{@search.longitude}&key=#{ENV['GOOGLE_API_KEY']}")
  end

  private

  def home
    controller_name == 'pages' && action_name == 'home'
  end
end
