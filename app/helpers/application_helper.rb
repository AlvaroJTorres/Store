module ApplicationHelper
  def current_order
    Order.find_by_id(session[:order_id]).nil? ? Order.new : Order.find_by_id(session[:order_id])
  end
end
