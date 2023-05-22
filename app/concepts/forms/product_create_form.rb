# frozen_string_literal: true

module Forms
  # Form object for Product Model
  class ProductCreateForm < Reform::Form
    property :name
    property :description
    property :price
    property :stock
    property :avatar

    validates :name, presence: true
    validates :price, :stock, presence: true, numericality: { greater_than: 0 }
    validates_uniqueness_of :name
  end
end
