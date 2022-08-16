# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    status { 'MyString' }
    customer_id { 'MyString' }
  end
end
