# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Restaurant.destroy_all
Comment.destroy_all

10.times do
  User.create(
    email: Faker::Internet.email,
    password: 'password'
  )
end

User.all.each do |user|
  rand(3).times do
    user.restaurants.create(
      name: Faker::Hipster.word,
      address: Faker::Address.street_address
    )
  end
end

Restaurant.all.each do |restaurant|
  rand(3).times do
    restaurant.comments.create(
      content: Faker::RickAndMorty.quote,
      user: User.all.sample
    )
  end
end
