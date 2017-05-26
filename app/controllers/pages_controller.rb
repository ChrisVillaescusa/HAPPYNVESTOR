class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :demo ]

  def home
    @search = Search.new
    @types = Type.all.order(name: :asc)
    # Search.find(36).results.create
  end

  def demo
    Search.last.results.create
  end
end
