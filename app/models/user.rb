# frozen_string_literal: true

# Class that represents the Model for the User schema
# Build with Devise gem
class User < ApplicationRecord
  after_create :link_to_stripe
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def active_for_authentication?
    super and !deleted_at?
  end

  def inactive_message
    'User does not exists.'
  end

  has_many :orders, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :first_name, :last_name, :address, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, numericality: true, length: { is: 9 }

  enum role: { customer: 0, admin: 1, support: 2 }

  private

  def link_to_stripe
    customer = Stripe::Customer.create(email:)
    update(stripe_customer_id: customer.id)
  end
end
