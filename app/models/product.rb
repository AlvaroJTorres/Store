# frozen_string_literal: true

# Model for Product
class Product < ApplicationRecord
  attr_accessor :changed_by

  before_update :new_log_update

  has_many :order_lines, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :logs, as: :loggable

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
    stock >= quantity
  end

  def update_stock(quantity)
    self[:stock] -= quantity
  end

  private

  def new_log_update
    return unless changed_by.admin?

    changes.each do |key, value|
      unless key == 'updated_at'
        logs.create(attr: key, old_val: value[0], new_val: value[1],
                    user_id: changed_by.id)
      end
    end
  end
end
