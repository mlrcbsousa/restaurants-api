# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'deleting data...'
Comment.destroy_all
puts 'deleted comments'
Restaurant.destroy_all
puts 'deleted restaurants'
User.destroy_all
puts 'deleted users'

puts 'creating users...'
10.times { User.create(email: Faker::Internet.email, password: 'password') }
puts "created #{User.count} users"

puts 'creating restaurants...'
User.all.each do |user|
  rand(1..2).times do
    user.restaurants.create(
      name: Faker::Hipster.word,
      address: Faker::Address.street_address
    )
  end
end
puts "created #{Restaurant.count} restaurants"

puts 'creating comments...'
Restaurant.all.each do |restaurant|
  rand(1..3).times do
    restaurant.comments.create(
      content: Faker::TheITCrowd.quote,
      user: User.all.sample
    )
  end
end
puts "created #{Comment.count} comments"
