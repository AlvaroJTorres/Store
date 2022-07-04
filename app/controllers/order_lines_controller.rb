class OrderLinesController < ApplicationController
  before_action :set_order

  def create
    @order_item = @order.add_product(order_line_params)
    @order.save
    session[:order_id] = @order.id

    redirect_to cart_path
  end

  def updated
    @order_item = @order.order_lines.find(params[:id])
    @order_item.update(order_line_params)
  end

  def destroy
    @order_item = @order.order_lines.find(params[:id])
    @order_item.destroy
  end

  private
  def order_line_params
    params.require(:order_line).permit(:product_id, :quantity)
  end

  def set_order
    @order = current_order
  end
end
