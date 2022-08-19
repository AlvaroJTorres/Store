# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'json'

products_data = JSON.parse(File.read('db/data/products.json'), symbolize_names: true)
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
  role: 1,
}

User.create(admin_data)

support_data = {
  email: 'support@mail.com',
  password: '123456',
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  address: Faker::Address.street_address,
  phone: Faker::PhoneNumber.subscriber_number(length: 9),
  role: 2
}

User.create(support_data)

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

# facebook_customer_data = {
#     email: "bluelight3001@hotmail.com",
#     password: '123456',
#     first_name: "Alvaro Julian",
#     last_name: "Torres Malla",
#     address: Faker::Address.street_address,
#     phone: Faker::PhoneNumber.subscriber_number(length: 9),
#     facebook_id: "5614316765255774"
# }

# User.create(facebook_customer_data)
puts 'Finished seeding users'

puts 'Seeding tags'
tags_data.each do |tag|
  Tag.create(name: tag)
end

puts 'Finished seeding tags'

puts 'Seeding products'
products_data.each do |product_data|
  product = {
    name: product_data[:name],
    description: product_data[:description],
    price: product_data[:price],
    stock: product_data[:stock]
  }

  new_product = Product.new(product)

  stripe_product = Stripe::Product.create({name: product_data[:name]})

  stripe_price = Stripe::Price.create({
    unit_amount: product_data[:price].to_i * 100,
    currency: 'usd',
    product: stripe_product.id
  })

  new_product.stripe_product_id = stripe_price.id

  new_product.avatar.attach(io: File.open('public/images/avatar.png'), filename: 'avatar.png')

  new_product.save

  product_data[:tags].each do |tag|
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
  product3.likes.create(user_id: i)
end

puts 'Finished seeding likes'
