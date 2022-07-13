# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'Default' }
    last_name { 'Default' }
    sequence(:email) { |n| "Test#{n}@mail.com" }
    password { '123456' }
    address { 'Default' }
    phone { '123456789' }
    role { 0 }
  end
end
