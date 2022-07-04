class Order < ApplicationRecord
  # belongs_to :user
  has_many :order_lines, dependent: :destroy

  # validates :date, presence: true
  # validates :total, presence: true, numericality: { greater_than: 0 }

  enum status: { recieved: 0, on_route: 1, delivered: 2 }

  def add_product(params)
    current_order_line = order_lines.find_by(product_id: params[:product_id])
    if current_order_line
      current_order_line.quantity += params[:quantity].to_i
      current_order_line.save
    else
      current_order_line = order_lines.new(params)
    end
    current_order_line
  end
end
