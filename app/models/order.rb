class Order < ApplicationRecord
  before_save :set_total

  has_many :order_lines, dependent: :destroy

  enum status: { recieved: 0, on_route: 1, delivered: 2 }

  def add_product(params)
    current_order_line = order_lines.find_by(product_id: params[:product_id])
    if current_order_line
      current_order_line.quantity += params[:quantity].to_i
      
    else
      current_order_line = order_lines.new(params)
    end
    current_order_line.save
    current_order_line
  end

  private

  def set_total
    self[:total] = order_lines.sum(&:total)
  end
end
