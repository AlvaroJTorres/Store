# frozen_string_literal: true

# Class that represents the Model for the Product schema
class Product < ApplicationRecord
  # Saves which user did a change on the Product
  attr_accessor :changed_by

  before_update :new_log_update

  has_many :order_lines, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :logs, as: :loggable
  has_many :comments, as: :commentable, dependent: :destroy
  has_and_belongs_to_many :tags

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock, presence: true, numericality: { greater_than: 0 }

  # Method that filters the list of products per name
  def self.filter_by_term(term)
    where('products.name LIKE ?', "%#{term}%")
  end

  # Method that filters the list of products by its tags
  def self.filter_by_tag(tag)
    joins(products_tags: :tag).where(tags: { id: tag })
  end

  # Method that filters the products by alphabetical order
  def self.filter_by_letter(direction)
    order("name #{direction}")
  end

  # Method that filters the products by the amount of likes
  def self.filter_by_likes_count(direction)
    order("likes_count #{direction}")
  end

  # Method that checks which user liked the current product
  def liked_by?(current_user)
    likes.where(user_id: current_user.id).exists?
  end

  # Method that finds which user liked the current product
  def find_like(current_user)
    likes.find_by(user_id: current_user.id)
  end

  # Method that checks if the quantity passed on the order_line is
  # less than the stock of the product
  def available_stock?(quantity)
    stock >= quantity
  end

  # Method that updates the stock of a product after the order is saved
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
