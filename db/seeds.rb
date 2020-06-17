User.create!(name: "Example User",
             phone: "23423423",
             email: "example@railstutorial.org",
             password: "foobar",
             password_confirmation: "foobar",
             activated: true,
             activated_at: Time.zone.now)

20.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now)
end
