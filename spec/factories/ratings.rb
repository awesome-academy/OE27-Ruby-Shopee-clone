FactoryBot.define do
  factory :rating do |f|
    f.star {5}
    f.product {FactoryBot.create :product}
    f.user {FactoryBot.create :user}
  end
end
