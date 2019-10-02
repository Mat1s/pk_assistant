class ServiceType < ApplicationRecord
  has_many :organizations
  has_many :services
end