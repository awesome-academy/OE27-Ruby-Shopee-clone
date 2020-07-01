FactoryBot.define do
  factory :order_item do |f|
    f.quantity {5}
    f.price_product {100}
    f.order {FactoryBot.create :order}
    f.product {FactoryBot.create :product}
  end
end

