# frozen_string_literal: true

# Class that represents the Model for the OrderLine schema
class OrderLine < ApplicationRecord
  before_save :set_total
  after_update :update_total
  after_destroy :update_total

  belongs_to :order
  belongs_to :product

  private

  def set_total
    self[:total] = product.price * quantity
  end

  def update_total
    order.save
  end
end
