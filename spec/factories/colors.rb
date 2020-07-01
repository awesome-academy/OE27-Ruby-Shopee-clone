FactoryBot.define do
  factory :color do |f|
    f.color {Faker::Color.color_name}
  end
end
