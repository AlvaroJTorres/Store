class Order < ApplicationRecord
  belongs_to :user
  has_many :order_lines, dependent: :destroy

  validates :date, presence: true
  validates :total, presence: true, numericality: { greater_than: 0 }

  enum status: { recieved: 0, on_route: 1, delivered: 2 }
end
