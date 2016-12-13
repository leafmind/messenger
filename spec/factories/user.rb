FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person_#{n}@example.com" }
    sequence(:name) { |n| "person_#{n}" }
    password "password"
    password_confirmation "password"
  end
end
