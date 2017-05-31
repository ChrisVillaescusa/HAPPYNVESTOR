module ApplicationHelper

  def render_navbar
    render 'shared/navbar' unless home
  end

  def display_static_map(search, size)
    zoom = 12
    size = size
    URI.encode("https://maps.googleapis.com/maps/api/staticmap?center=#{search.latitude},#{search.longitude}&zoom=#{zoom}&size=#{size}&markers=color:red|#{search.latitude},#{search.longitude}&key=#{ENV['GOOGLE_API_KEY']}")
  end

  private

  def home
    controller_name == 'pages' && action_name == 'home'
  end
end
