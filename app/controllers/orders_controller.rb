class OrdersController < ApplicationController
  before_action :set_order

  def show
    @order_lines = current_order.order_lines
  end

  def update
    authorize @order
    @order.date = Time.now
    @order.status = 1
    if @order.save
      @order.order_lines.each do |order_line|
        product = Product.find(order_line.product_id)
        product.changed_by = current_user
        product.stock -= order_line.quantity
        product.save
      end

      session.delete(:order_id)
      redirect_to products_path
      
    else
      render :show
    end
  end

  private
  def order_params
    params.require(:order).permit(:user_id, :date, :status)
  end

  def set_order
    @order = current_order
  end
end
