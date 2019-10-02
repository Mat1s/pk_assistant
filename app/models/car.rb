class Car < ApplicationRecord
  has_many :operations
  
  belongs_to :user
end
