class Product < ApplicationRecord
  has_many :order_lines, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock, presence: true, numericality: { greater_than: 0 }

  def self.search_by(term)
    where('name LIKE ?', "%#{term}%")
  end

  def liked_by?(current_user)
    likes.where(user_id: current_user.id).exists?
  end

  def find_like(current_user)
    likes.find_by(user_id: current_user.id)
  end

  def available_stock?(quantity)
    self.stock >= quantity
  end

  def update_stock(quantity)
    self[:stock] -= quantity
  end
end
