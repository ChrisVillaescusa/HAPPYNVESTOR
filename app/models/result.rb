class Result < ApplicationRecord
  belongs_to :search
  has_attachment :photo
end
