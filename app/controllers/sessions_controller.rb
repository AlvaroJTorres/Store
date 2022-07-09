# frozen_string_literal: true

# Controllers for Sessions
class SessionsController < Devise::SessionsController
  after_action :after_login, only: :create

  def after_login
    return unless current_user.customer?

    order = Order.find_by(user_id: current_user.id,
                          status: 'in_process') || current_order
    order.user_id = current_user.id
    order.save
    session[:order_id] = order.id
  end
end
