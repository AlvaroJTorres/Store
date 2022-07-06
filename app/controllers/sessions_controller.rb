class SessionsController < Devise::SessionsController
  after_action :after_login, :only => :create

  def after_login
    if current_user.customer?      
      order = current_order
      order.user_id = current_user.id
      order.save
      session[:order_id] = order.id
    end
  end
end
