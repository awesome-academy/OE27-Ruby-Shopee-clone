FactoryBot.define do
  factory :user do |f|
    f.name {Faker::Name.name}
    f.email {Faker::Internet.email}
    f.password {"123qwe"}
    f.password_confirmation {"123qwe"}
    f.activated {1}
  end
end

