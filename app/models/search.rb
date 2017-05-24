class Search < ApplicationRecord
  belongs_to :type
  belongs_to :user
  has_many :results, dependent: :destroy

  validates :address, :type_id, presence: true
  validates :budget, numericality: { only_integer: true }
end
