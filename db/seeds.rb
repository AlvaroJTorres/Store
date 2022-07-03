# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'json'

products_data = JSON.parse(File.read('db/data/products.json'))

puts 'Start seeding'

puts 'Seeding users'
admin_data = {
  email: "alvaro@mail.com",
  password: "123456",
  first_name: "Alvaro",
  last_name: "Torres",
  address: Faker::Address.street_address,
  phone: Faker::PhoneNumber.subscriber_number(length: 9),
  role: 1
}

User.create(admin_data)

customer_data = {
  email: "test1@mail.com",
  password: "123456",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  address: Faker::Address.street_address,
  phone: Faker::PhoneNumber.subscriber_number(length: 9)
}

User.create(customer_data)
puts 'Finished seeding users'

puts 'Seeding products'
products_data.each do |product_data|
  Product.create(products_data)
end
puts 'Finished seeding products'