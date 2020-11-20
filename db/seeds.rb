User.create!(full_name: "Hajime Kawajiri",
              name:  "hajime",
              email: "hajime_kawajiri@outlook.jp",
              password:              "foobar",
              password_confirmation: "foobar",
              admin: true)

99.times do |n|
  full_name  = Faker::Name.name
  name  = Faker::JapaneseMedia::OnePiece.character
  email = "insta-clone-#{n+1}@example.com"
  password = "password"
  User.create!( full_name: full_name,
                name:  name,
                email: email,
                password:              password,
                password_confirmation: password)
end