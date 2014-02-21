# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    #name 'Bob Marley'
    username 'rndguzmanjr'
    email 'rndguzmanjr@gmail.com'
    password 'password'
    password_confirmation 'password'
    pin '1234'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end
