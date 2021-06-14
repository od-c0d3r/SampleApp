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