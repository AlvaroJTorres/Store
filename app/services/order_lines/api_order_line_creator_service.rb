# frozen_string_literal: true

module OrderLines
  # Service Object to Create a Order Line on API
  class ApiOrderLineCreatorService < OrderLineCreatorService
    def initialize(order, user, params)
      super(order, params)
      @order = order
      @user = user
      @params = params
    end

    def call
      order_line_form = OrderLineForm.new(@params)

      if order_line_form.valid?
        order_line = new_or_existing_product(@order, @params)

        @order.user_id = @user.id if @order.user_id.nil?

        order_line.save

        @order.save

        OrderLineRepresenter.new(order_line)
      else
        false
      end
    end
  end
end
