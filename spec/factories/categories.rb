FactoryBot.define do
  factory :category do |f|
    f.name {Faker::Name.unique.name}
    f.slug {Faker::Internet.unique.slug}
  end
end

