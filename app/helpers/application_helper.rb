module ApplicationHelper


  def render_navbar
    render 'shared/navbar' unless home
  end

  private

  def home
    controller_name == 'pages' && action_name == 'home'
  end


end
