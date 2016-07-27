FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@gmail.com" }
    password "asdfgh"
    password_confirmation "asdfgh"
    name "blah"
  end
end
