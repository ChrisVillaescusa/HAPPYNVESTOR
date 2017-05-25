class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @search = Search.new
    @types = Type.all.order(name: :asc)
    SearchChannel.broadcast_to(
      "search_29",
      title: 'New things!',
      body: 'All the news fit to print'
    )
  end

end
