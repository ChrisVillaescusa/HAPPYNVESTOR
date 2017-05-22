class Type < ApplicationRecord

  has_many :searches
  has_many :users, through: :searches
  has_many :results, through: :searches

end
