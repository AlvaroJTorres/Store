# frozen_string_literal: true

module Forms
    # Form object for User Model
    class UserForm < Reform::Form
        property :email
        property :password
        property :first_name
        property :last_name
        property :address
        property :phone
        property :role
    
        validates :email, :password, :first_name, :last_name, :address, :phone, presence: true
        validates :role, inclusion: { in: [0, 2] }
        validates_uniqueness_of :email
    end
end