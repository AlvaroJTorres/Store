# frozen_string_literal: true

# Form object for User Model
class UserForm
  include ActiveModel::Model

  attr_accessor :email, :password, :first_name, :last_name, :address, :phone, :role

  validates :email, :password, :first_name, :last_name, :address, :phone, presence: true
  validates :role, inclusion: { in: %w[0 2] }

  def create!
    raise ActiveRecord::RecordInvalid, self unless valid?

    User.create(attributes)
  end

  def attributes
    {
      email:,
      password:,
      first_name:,
      last_name:,
      address:,
      phone:,
      role: role.to_i
    }
  end
end
