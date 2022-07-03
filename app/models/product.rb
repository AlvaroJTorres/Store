class Product < ApplicationRecord
  has_many :order_lines, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock, presence: true, numericality: { greater_than: 0 }

  def self.search_by(term)
    where('name LIKE ?', "%#{term}%")
  end
end
