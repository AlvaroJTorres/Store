# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'json'

products_data = JSON.parse(File.read('db/data/products.json'))
tags_data = JSON.parse(File.read('db/data/tags.json'))

puts 'Start seeding'

puts 'Seeding users'
admin_data = {
  email: 'alvaro@mail.com',
  password: '123456',
  first_name: 'Alvaro',
  last_name: 'Torres',
  address: Faker::Address.street_address,
  phone: Faker::PhoneNumber.subscriber_number(length: 9),
  role: 1
}

User.create(admin_data)

5.times do |i|
  customer_data = {
    email: "test#{i + 1}@mail.com",
    password: '123456',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: Faker::Address.street_address,
    phone: Faker::PhoneNumber.subscriber_number(length: 9)
  }
  User.create(customer_data)
end

puts 'Finished seeding users'

puts 'Seeding tags'
Tag.create(tags_data)
puts 'Finished seeding tags'

puts 'Seeding products'
products_data.each do |product_data|
  product = {
    name: products_data[:name],
    description: products_data[:description],
    price: products_data[:price],
    stock: products_data[:stock]
  }

  new_product = Product.create(product)

  products_data[:tags].each do |tag|
    new_product.tags << Tag.find_by(name: tag)
  end
end

puts 'Finished seeding products'

puts 'Seeding likes'
product10 = Product.find(10)
(2..6).each do |i|
  product10.likes.create(user_id: i)
end

product15 = Product.find(15)
(3..6).each do |i|
  product15.likes.create(user_id: i)
end

product3 = Product.find(3)
(2..4).each do |i|
  product15.likes.create(user_id: i)
end
puts 'Finished seeding likes'