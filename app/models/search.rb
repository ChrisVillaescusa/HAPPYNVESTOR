class Search < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  belongs_to :type
  belongs_to :user
  has_many :results, dependent: :destroy

  validates :address, :type_id, presence: true
  validates :budget, numericality: { only_integer: true }

  after_create :scrap_results

  private

  def scrap_results
    Scrapper.perform_later(self.id)
  end
end
