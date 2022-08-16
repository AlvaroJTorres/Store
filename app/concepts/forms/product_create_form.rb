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
        # validate :unique_name
    
        # # Method that validates uniqueness of a name
        # def unique_name
        # return unless name
    
        # errors.add(:unique_name, 'Name already taken') if name.downcase == Product.find_by(name:)&.name
        # end
    end
end

  