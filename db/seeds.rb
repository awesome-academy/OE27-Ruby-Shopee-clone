20.times do |n|
  Review.create!(
    content: "ffhsjdhfsdkjfhsdkj",
    product_id: Product.pluck(:id).sample,
    user_id: User.pluck(:id).sample
    )
end
