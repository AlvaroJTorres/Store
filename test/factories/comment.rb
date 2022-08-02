# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    body { 'Default' }
    rate { 0 }
    user
    for_product

    trait :for_product do
      association :commentable, factory: :product
    end

    trait :for_order do
      association :commentable, factory: :order
    end

    trait :for_user do
      association :commentable, factory: :user
    end
  end
end
