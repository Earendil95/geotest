FactoryBot.define do
  factory :building do
    address { Faker::Address.full_address }
    longitude { Faker::Address.longitude }
    latitude { Faker::Address.latitude }

    after(:build) do |building, evaluator|
      building.coordinates = "POINT(#{evaluator.longitude} #{evaluator.latitude})"
    end
  end
end
