class Result < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  belongs_to :search
  has_attachment :photo

  after_create :publish_on_cable

private

  def publish_on_cable
    SearchChannel.broadcast_to(
      "search_#{self.search.id}",
      title: 'New things!',
      body: 'All the news fit to print'
    )
  end
end
