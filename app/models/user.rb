class User < ApplicationRecord
  enum role: [:user, :admin, :organization]

  ratyrate_rater

  has_one :profile
  has_many :organizations
  has_many :cars

  devise :database_authenticatable, :registerable, :confirmable, 
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: [:facebook, :twitter, :linkedin]

  accepts_nested_attributes_for :profile

  after_initialize :set_default_role, :if => :new_record?

  validates :email, presence: true

  private

  def set_default_role
    self.role ||= :user
  end
end
