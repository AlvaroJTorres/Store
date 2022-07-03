class Product < ApplicationRecord
  has_many :order_lines, dependent: :destroy
end
