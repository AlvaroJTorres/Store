# frozen_string_literal: true

module Forms
  # Form object for Order Line Model
  class OrderLineForm < Reform::Form
    property :quantity
    property :product_id

    validates :product_id, presence: true
    validates :quantity, presence: true, numericality: { greater_than: 0 }

    validate :check_stock

    validate :validate_product

    # Method that add an error if the product available_stock? method returns errors
    def check_stock
      product = Product.find_by(id: product_id)

      return unless product

      errors.add(:quantity, :amount, message: 'Not enough stock') unless product.available_stock?(quantity.to_i)
    end

    def validate_product
      return if Product.where('deleted_at IS NULL').find_by(id: product_id)

      errors.add(:product_id, :deleted, message: 'Product not found')
    end
  end
end
