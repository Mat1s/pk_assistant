class Organization < ApplicationRecord
  include AASM

  aasm do
  end
  include AASM

  paginates_per 6

  has_many :service_for_organizations, dependent: :destroy
  has_many :organization_addresses, dependent: :destroy
  has_many :services, through: :service_for_organizations
  has_many :rating_caches

  belongs_to :user
  belongs_to :service_type

  accepts_nested_attributes_for :service_for_organizations
  accepts_nested_attributes_for :organization_addresses

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true
  validates :phone, length: 5..15, presence: true

  ratyrate_rateable 'name'

  aasm do
    state :unverified, initial: true
    state :verified
    state :rejected
    state :published
    state :archived

    event :verify do
      transitions from: [:unverified], to: :verified
    end
    event :reject do
      transitions from: [:unverified], to: :rejected
    end
    event :reverify do
      transitions from: [:verified], to: :unverified
    end
    event :publish do
      transitions from: [:verified], to: :published
    end
    event :unpublish do
      transitions from: [:published], to: :verified
    end
    event :archive do
      transitions from: [:published, :verified, :unverified], to: :archived
    end
  end
end
