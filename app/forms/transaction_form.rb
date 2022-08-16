# frozen_string_literal: true

# Form object for Comment Model
class TransactionForm
  include ActiveModel::Model

  attr_accessor :status, :user_id, :order_id

  validates :status, :user_id, :order_id, presence: true
end
