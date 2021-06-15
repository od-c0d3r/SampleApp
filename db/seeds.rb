User.create!(name:  "Omar Rashad",
             email: "o.rashad2020@gmail.com",
             password:              "omaromar",
             password_confirmation: "omaromar",
             admin: true)

# Generate a bunch of additional users.
99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(name:  name,
                 email: email,
                 password:              password,
                 password_confirmation: password)
end


# Generate microposts for a subset of users.
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end
