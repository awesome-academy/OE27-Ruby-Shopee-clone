FactoryBot.define do
  factory :product_color do |f|
    f.quantity {2}
    f.product {FactoryBot.create :product}
    f.color {FactoryBot.create :color}
  end
end

