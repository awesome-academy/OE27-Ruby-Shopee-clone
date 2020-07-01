FactoryBot.define do
  factory :brand do |f|
    f.name {Faker::Name.unique.name}
    f.slug {Faker::Internet.unique.slug}
    f.phone {Faker::PhoneNumber.unique.phone_number}
  end
end

