class OrderLinesController < ApplicationController
  before_action :set_order
  before_action :set_order_line, only: %i[update destroy]

  def create
    @order_line = authorize @order.order_lines.find_by(product_id: order_line_params[:product_id]) || @order.order_lines.new(order_line_params)

    if @order_line.persisted?
      @order_line.quantity += order_line_params[:quantity].to_i
    end

    if @order_line.save
      @order.save

      session[:order_id] = @order.id

      redirect_to cart_path
    else
      if params[:term]
        @products = Product.search_by(params[:term])
      else
        @products = Product.all
      end
      render "products/index"
    end
  end

  def update
    @order_line.quantity = order_line_params[:quantity]
    
    @order_line.save

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
