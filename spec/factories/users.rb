FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "user#{i}@example.com" }
    password              { '1234567' }
    password_confirmation { '1234567' }
    confirmed_at          { Time.now }

    after(:build) do |user|
      user.skip_confirmation!
      user.confirm
    end

    after(:create) do |user|
      create(:profile, user: user)
    end
  end

  factory :admin_user, aliases: [:admin] do
    sequence(:email) { |i| "admin#{i}@example.com" }
    password              { '1234567' }
    password_confirmation { '1234567' }
    confirmed_at          { Time.now }

    after(:build) do |user|
      user.skip_confirmation!
      user.confirm
      user.role = :admin
    end

    after(:create) do |user|
      create(:profile, user: user)
    end
  end
end