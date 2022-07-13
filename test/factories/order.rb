# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    association :user
    date { '2022-01-01' }
    total { 100.00 }
    status { 0 }
  end
end
