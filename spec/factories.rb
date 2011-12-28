# By using the symbol ":user", we get Factory Girl to simulate the User model
# basic factory
Factory.define :user do |user|
  user.name  "Michael Hartl"
  user.email "mhartl@example.com"
  user.password "foobar"
  user.password_confirmation "foobar"
end

# use sequences to make many (Listing 10.29)
Factory.sequence :name do |n|
  "Person #{n}"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end
