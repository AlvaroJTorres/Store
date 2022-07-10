# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :body, presence: true
  validates :rate, presence: true, numericality: { in: 1..5 }
end
