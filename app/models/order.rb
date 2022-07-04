class Order < ApplicationRecord
  # belongs_to :user
  has_many :order_lines, dependent: :destroy

  # validates :date, presence: true
  # validates :total, presence: true, numericality: { greater_than: 0 }

  enum status: { recieved: 0, on_route: 1, delivered: 2 }

  private

  def self.set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end
