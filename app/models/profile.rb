class Profile < ApplicationRecord
  mount_uploader :image, AvatarUploader

  belongs_to :user

  validates :address, :firstname, :surname, :image, presence: true
  validates :nickname, presence: true, uniqueness: true
  validates_size_of :image, maximum: 3.megabytes
end
