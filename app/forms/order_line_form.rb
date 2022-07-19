# frozen_string_literal: true

# Form object for Order Line Model
class OrderLineForm
  include ActiveModel::Model

  attr_accessor :quantity, :product_id

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  validate :check_stock

  # Method that add an error if the product available_stock? method returns a false
  def check_stock
    product = Product.find(product_id)

    errors.add(:quantity, :amount, message: 'Not enough stock') unless product.available_stock?(quantity.to_i)
  end
end
