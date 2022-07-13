# frozen_string_literal: true

FactoryBot.define do
  factory :log do
    attr { 'price ' }
    old_val { 10 }
    new_val { 20 }
    association :user
    for_product

    trait :for_product do
      association :loggable, factory: :product
    end
  end
end
