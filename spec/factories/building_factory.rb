FactoryBot.define do
  factory :building do
    address { Faker::Address.full_address }
    longitude { Faker::Address.longitude }
    latitude { Faker::Address.latitude }
  end
end
