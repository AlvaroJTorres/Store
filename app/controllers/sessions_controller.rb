# frozen_string_literal: true

# Define additional controlers for the Devise Session controller
class SessionsController < Devise::SessionsController
  after_action :after_login, only: :create

  # Method that runs after a successful login to define is the order that is display
  # in the /cart is the session order or the order linked to the user
  def after_login
    return unless current_user.customer?

    order = Order.find_by(user_id: current_user.id,
                          status: 'in_process') || current_order
    order.user_id = current_user.id
    order.save
    session[:order_id] = order.id
  end
end
