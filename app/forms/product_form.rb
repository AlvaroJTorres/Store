# frozen_string_literal: true

# Form object for Product Model
class ProductForm
  include ActiveModel::Model

  attr_accessor :name, :description, :price, :stock

  validates :name, presence: true, on: :create
  validates :price, :stock, presence: true, numericality: { greater_than: 0 }
  validate :unique_name, on: :update

  # Method that validates uniqueness of a name
  def unique_name
    errors.add(:unique_name, 'Name already taken') if name == Product.find_by(name:)&.name
  end
end
