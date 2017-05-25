class Result < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  belongs_to :search
  has_attachment :photo

  after_create :publish_on_cable

private

  def publish_on_cable
    # TODO: find the channel
    # TODO: publish partial on channel search_#{self.search.id}
  end
end
