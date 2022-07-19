# frozen_string_literal: true

# Form object for Comment Model
class CommentForm
  include ActiveModel::Model

  attr_accessor :body, :rate

  validates :body, presence: true
  validates :rate, numericality: { in: 0..5 }
end
