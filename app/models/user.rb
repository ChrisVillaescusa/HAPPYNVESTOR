class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :searches
  has_attachment :photo
  validates :first_name, :last_name, presence: true
end
