# frozen_string_literal: true

# Form object for Comment Model on API
class ApiCommentForm
  include ActiveModel::Model

  attr_accessor :body, :rate, :user_id

  validates :body, presence: true
  validates :rate, numericality: { in: 0..5 }

  validate :validate_user

  def validate_user 
    errors.add(:user_id, :deleted, message: 'User not found') unless User.where('deleted_at IS NULL').find_by(id: user_id)
  end
end