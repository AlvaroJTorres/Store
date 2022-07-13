# frozen_string_literal: true

# Class that represents the Model for the User schema
# Build with Devise gem
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, dependent: :destroy

  validates :first_name, :last_name, :address, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, numericality: true, length: { is: 9 }

  enum role: { customer: 0, admin: 1 }
end
