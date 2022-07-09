# frozen_string_literal: true

# Model for Order Line
class OrderLine < ApplicationRecord
  before_save :set_total
  after_update :update_total
  after_destroy :update_total

  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  validate :check_stock

  def check_stock
    errors.add(:quantity, :amount, message: 'Not enough stock') unless product.available_stock?(quantity)
  end

  private

  def set_total
    self[:total] = product.price * quantity
  end

  def update_total
    order.save
  end
end
