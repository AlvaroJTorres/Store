# frozen_string_literal: true

module Operations
  module OrderOperations
    # Operation to update Orders on API
    class ApiUpdate < Trailblazer::Operation
      pass :find_order
      step :update_order
      step :update_stock
      step :representer

      def find_order(options, params:, **)
        options[:model] = Order.find_by(id: params)
      end

      def update_order(options, user:, **)
        options[:model].user_id = user.id if options[:model].user_id.nil?
        options[:model].date = Time.now
        options[:model].status = 1
        options[:model].save
      end

      def update_stock(options, user:, **)
        options[:model].order_lines.each do |order_line|
          product = Product.find(order_line.product_id)
          product.changed_by = user
          product.stock -= order_line.quantity
          ProductMailer.with(product:).alert_stock_email.deliver_later if product.stock <= 3
          product.save
        end
      end

      def representer(options, model:, **)
        options[:model] = Representers::OrderRepresenter.new(model)
      end
    end
  end
end
