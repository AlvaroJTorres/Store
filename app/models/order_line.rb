class OrderLine < ApplicationRecord
  before_save :set_total

  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  # validates :total, presence: true, numericality: { greater_than: 0 }

  private

  def set_total
    self[:total] = product.price * quantity
  end
end
