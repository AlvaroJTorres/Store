class OrderLinesController < ApplicationController
  before_action :set_order
  before_action :set_order_line, only: %i[update destroy]

  def create
    @order_line = @order.add_product(order_line_params)
    authorize @order_line
    
    @order.save
    session[:order_id] = @order.id

    redirect_to cart_path
  end

  def update
    @order_line.update(order_line_params)

    redirect_to cart_path
  end

  def destroy
    @order_line.destroy

    redirect_to cart_path
  end

  private
  def order_line_params
    params.require(:order_line).permit(:product_id, :quantity)
  end

  def set_order
    @order = current_order
  end

  def set_order_line
    @order_line = authorize @order.order_lines.find(params[:id])
  end
end
