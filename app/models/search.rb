class Search < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  belongs_to :type
  belongs_to :user
  has_many :results, dependent: :destroy

  validates :address, :type_id, presence: { message: "Saisissez une adresse valide" }
  validates :budget, numericality: { message: "Veuillez saisir un budget" }
  after_create :scrap_results

  private

  def scrap_results
    Scrapper.set(wait: 3.seconds).perform_later(self.id)
  end
end
