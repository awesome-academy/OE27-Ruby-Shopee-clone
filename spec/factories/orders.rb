FactoryBot.define do
  factory :order do |f|
    f.address {Faker::Address.street_address}
    f.user {FactoryBot.create :user}
    f.status {Settings.min}
  end
end

