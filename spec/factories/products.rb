FactoryBot.define do
  factory :product do |f|
    f.name {Faker::Name.unique.name}
    f.description {Faker::Lorem.sentence}
    f.price {100}
    f.brand {FactoryBot.create :brand}
    f.category {FactoryBot.create :category}
    f.user {FactoryBot.create :user}
  end
end
