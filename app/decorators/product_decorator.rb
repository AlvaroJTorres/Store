# frozen_string_literal: true

# Decorator for product price
class ProductDecorator < Draper::Decorator
  delegate_all

  def price_in_dollars
    format('%.2f', price)
  end
end
