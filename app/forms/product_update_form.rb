# frozen_string_literal: true

# Form object for Product Model
class ProductUpdateForm
  include ActiveModel::Model

  attr_accessor :name, :description, :price, :stock, :id, :avatar

  validates :price, :stock, numericality: { greater_than: 0 }, allow_nil: true
  validate :unique_name

  # Method that validates uniqueness of a name
  def unique_name
    return unless name

    check_products = Product.where.not(id:).find_by(name:)

    errors.add(:unique_name, 'Name already taken') if name.downcase == check_products&.name
  end
end
