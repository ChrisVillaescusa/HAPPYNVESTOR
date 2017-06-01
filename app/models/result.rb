class Result < ApplicationRecord
  geocoded_by :address
  # after_validation :geocode, if: :address_changed?
  belongs_to :search
  # has_attachment :photo

  # after_create :publish_on_cable

  def picture
    if self.img?
       "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.2)), url('#{self.img}'); background-size: cover !important; background-position: center;

"
    else
      "background-image: url('#{ActionController::Base.helpers.image_path 'missing_result_pic.svg'}'); background-position: center; background-size: 84%; background-repeat: no-repeat;"
    end
  end

private

  # def publish_on_cable
  #   ActionCable.server.broadcast(
  #     "search_#{self.search.id}",
  #     html: ApplicationController.new.render_to_string(partial: 'searches/result_card', locals: { result: self }, layout: false)
  #   )
  # end
end
