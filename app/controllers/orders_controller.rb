# frozen_string_literal: true

# Controllers for Orders
class OrdersController < ApplicationController
  before_action :set_order

  def cart
    @order_lines = current_order.order_lines
  end

  def update
    @order.user_id = current_user.id if @order.user_id.nil?
    @order.date = Time.now
    @order.status = 1
    if @order.save
      update_stock(@order)
      session.delete(:order_id)
      redirect_to products_path
    else
      render :cart
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :date, :status)
  end

  def set_order
    @order = authorize current_order
  end

  def update_stock(order)
    order.order_lines.each do |order_line|
      product = Product.find(order_line.product_id)
      product.changed_by = current_user
      product.stock -= order_line.quantity
      product.save
    end
  end
end
