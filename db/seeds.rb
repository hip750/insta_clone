User.create!(full_name: "Hajime Kawajiri",
              name:  "hajime",
              email: "hajime_kawajiri@outlook.jp",
              password:              "foobar",
              password_confirmation: "foobar",
              admin: true,
              activated: true,
              activated_at: Time.zone.now)

99.times do |n|
  full_name  = Faker::Name.name
  name  = Faker::JapaneseMedia::OnePiece.character
  email = "insta-clone-#{n+1}@example.com"
  password = "password"
  User.create!( full_name: full_name,
                name:  name,
                email: email,
                password:              password,
                password_confirmation: password,
                activated: true,
                activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.imageposts.create!(content: content) }
end