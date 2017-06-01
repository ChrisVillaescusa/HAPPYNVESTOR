class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @search = Search.new
    @types = Type.all.order(name: :asc)
    render layout: "home_layout"
  end

end
