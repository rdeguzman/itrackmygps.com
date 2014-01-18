# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :device do
    sequence(:uuid) { |n| "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx#{n}" }
  end
end
