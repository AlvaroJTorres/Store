# frozen_string_literal: true

# Helpers for overall Application views
module ApplicationHelper
  # Method that finds if an Order exists on the session so the user can keep working on it,
  # otherwise creates a new instance of an order to be filled with the neccesary data
  def current_order
    if Order.find_by_id(session[:order_id]).nil? || Order.find_by_id(session[:order_id]).status != 'in_process'
      Order.new
    else
      Order.find_by_id(session[:order_id])
    end
  end

  # Method that saves the string for the tailwind class to be reused in the buttons of the views
  def button_style
    'bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded'
  end
end
