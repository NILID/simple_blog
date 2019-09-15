require 'faker'

# User roles list
#
# 1  = guest
# 2  = user
# 4  = admin

FactoryBot.define do
  factory :user do
    login { Faker::Lorem.unique.characters(number: 5..9) }
    email { Faker::Internet.unique.email }

    password              { 'password' }
    password_confirmation { 'password' }
    confirmed_at          { Time.now }

    trait(:admin) do
      after(:create) { |u| u.update_attribute(:roles_mask, 4) }
    end

    trait(:user) do
      after(:create) { |u| u.update_attribute(:roles_mask, 2) }
    end
  end
end
