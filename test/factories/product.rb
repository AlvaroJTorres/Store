# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "name #{n}" }
    description { 'description' }
    price { 10.00 }
    stock { 100 }
    likes_count { 0 }
    avatar { Rack::Test::UploadedFile.new("public/images/avatar.png", 'image/png') }
  end
end
