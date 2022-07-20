# frozen_string_literal: true

# Form object for Product Model
class ProductCreateForm
  include ActiveModel::Model

  attr_accessor :name, :description, :price, :stock

  validates :name, presence: true
  validates :price, :stock, presence: true, numericality: { greater_than: 0 }
  validate :unique_name

  # Method that validates uniqueness of a name
  def unique_name
    return unless name
    
    errors.add(:unique_name, 'Name already taken') if name.downcase == Product.find_by(name:)&.name
  end

  def validate!
    raise ActiveRecord::RecordInvalid, self unless valid?

    Product.new(attributes)
  end

  def attributes
    {
      name: name.downcase,
      description:,
      price:,
      stock:
    }
  end
end
