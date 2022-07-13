# frozen_string_literal: true

# Helpers for overall Application views
module ApplicationHelper
  def current_order
    Order.find_by_id(session[:order_id]).nil? ? Order.new : Order.find_by_id(session[:order_id])
  end

  def button_style
    'bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded'
  end
end
