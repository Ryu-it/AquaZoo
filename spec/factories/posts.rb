FactoryBot.define do
  factory :post do
    name { Faker::Name.name }
    title { Faker::Book.title }
    body { Faker::Lorem.paragraph }

    association :user
    association :category
    association :area
  end
end
