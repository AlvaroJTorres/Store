# frozen_string_literal: true

# Class that represents the Model for the Product schema
class Product < ApplicationRecord
  # Saves which user did a change on the Product
  attr_accessor :changed_by

  before_update :new_log_update

  has_many :order_lines, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :logs, as: :loggable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_and_belongs_to_many :tags

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

  private

  def new_log_update
    return unless changed_by.admin? || changed_by.support?

    changes.each do |key, value|
      unless key == 'updated_at'
        logs.create(attr: key, old_val: value[0], new_val: value[1],
                    user_id: changed_by.id)
      end
    end
  end
end
