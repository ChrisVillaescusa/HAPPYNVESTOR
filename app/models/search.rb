class Search < ApplicationRecord
  belongs_to :type
  belongs_to :user
  has_many :results
end
