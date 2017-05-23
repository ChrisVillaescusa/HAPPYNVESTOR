class SearchesController < ApplicationController
  before_action :find_search, only: :show

  def index
  end

  def show
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
