# frozen_string_literal: true

FactoryBot.define do
  factory :order_line do
    association :order
    association :product
    quantity { 1 }
    total { product.price * quantity }
  end
end
