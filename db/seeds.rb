20.times do |n|
  name = Faker::Name.name
  Product.create!(
    name: name,
    price: 100,
    user_id: User.pluck(:id).sample,
    category_id: Category.pluck(:id).sample,
    brand_id: 1,
    count_rate: 1,
    total_star: 5,
    avg_star: 5,
    description: name,
    created_at: Time.zone.now
    )
end
