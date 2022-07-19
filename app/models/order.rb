# frozen_string_literal: true

# Class that represents the Model for the Order schema
class Order < ApplicationRecord
  before_save :set_total

  has_many :order_lines, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  enum status: { in_process: 0, recieved: 1, on_route: 2, delivered: 3 }

  private

  def set_total
    self[:total] = order_lines.sum(&:total)
  end
end
