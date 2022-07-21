class ProductDecorator < Draper::Decorator
  delegate_all
  
  def price_in_dollars
    '%.2f' % price
  end
end