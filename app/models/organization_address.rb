class OrganizationAddress < ApplicationRecord
  belongs_to :organization

  validates :street, :city, :house_number, presence: true
  validates :phone, length: 4..15, presence: true
end
