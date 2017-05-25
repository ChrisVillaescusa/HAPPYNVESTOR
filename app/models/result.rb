class Result < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  belongs_to :search
  has_attachment :photo

  after_create :publish_on_cable

private

  def publish_on_cable
    ActionCable.server.broadcast(
      "search_#{self.search.id}",
      html: ApplicationController.new.render_to_string(partial: 'searches/result_card', locals: { result: self }, layout: false)
    )
  end
end
