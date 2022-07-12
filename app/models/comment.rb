# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :body, presence: true
  validates :rate, numericality: { in: 0..5 }
end
