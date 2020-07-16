20.times do |n|
  ProductColor.create!(
    quantity: 100,
    product_id: Product.pluck(:id).sample,
    color_id: Color.pluck(:id).sample
    )
end
