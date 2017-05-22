class Search < ApplicationRecord
  belongs_to :type
  belongs_to :user
  has_many :results

  validates :address, :type_id, presence: true
  validates :budget, numericality: { only_integer: true }
end
