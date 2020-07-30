FactoryBot.define do
  factory :review do |f|
    f.content {Faker::Lorem.sentence}
    f.product {FactoryBot.create :product}
    f.user {FactoryBot.create :user}
  end
end
