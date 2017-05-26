class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :searches
  has_attachment :photo
  validates :first_name, :last_name, presence: true

  def avatar
    if self.photo?
      ActionController::Base.helpers.cl_image_path self.photo.path
    else
      'avatar_default.svg'
    end
  end
end
