# frozen_string_literal: true

# Controllers for Orders
class OrdersController < ApplicationController
  before_action :set_order, only: %i[update]

  def index
    @orders = Order.where(user_id: current_user.id, status: 'recieved')
  end

  def show
    @order = Order.find(params[:id])
  end

  def cart
    @order = current_order
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
    @order = authorize Order.find(params[:id])
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
