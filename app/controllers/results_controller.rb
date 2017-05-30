class ResultsController < ApplicationController
  before_action :set_result, only: [:show]

  def show
    render layout: false
  end

private

  def set_result
    @result = Result.find(params[:id])
  end
end
