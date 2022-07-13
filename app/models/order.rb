# frozen_string_literal: true

# Class that represents the Model for the Order schema
class Order < ApplicationRecord
  before_save :set_total

  has_many :order_lines, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  enum status: { in_process: 0, recieved: 1, on_route: 2, delivered: 3 }

  # Method that defines that if an order_line of a product already exists it 
  # updates the quantity value of the order_line, else it creates a new
  # instance of an order_line for the product.
  # Recieves all the params send to the order_line
  def add_product(params)
    current_order_line = order_lines.find_by(product_id: params[:product_id])
    if current_order_line
      current_order_line.quantity += params[:quantity].to_i

    else
      current_order_line = order_lines.new(params)
    end
    current_order_line.save
    current_order_line
  end

  private

  def set_total
    self[:total] = order_lines.sum(&:total)
  end
end
