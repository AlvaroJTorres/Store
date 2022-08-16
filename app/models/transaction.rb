# frozen_string_literal: true

# Class that represents the Model for the Transaction schema
class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :order
end
