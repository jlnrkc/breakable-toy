FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@hgmail.com" }
    password "asdfgh"
  end
end
