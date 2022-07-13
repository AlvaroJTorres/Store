# frozen_string_literal: true

# Helpers for overall Application views
module ApplicationHelper
  # Method that finds if an Order exists on the session so the user can keep working on it,
  # otherwise creates a new instance of an order to be filled with the neccesary data
  def current_order
    Order.find_by_id(session[:order_id]).nil? ? Order.new : Order.find_by_id(session[:order_id])
  end

  # Method that saves the string for the tailwind class to be reused in the buttons of the views
  def button_style
    'bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded'
  end
end
