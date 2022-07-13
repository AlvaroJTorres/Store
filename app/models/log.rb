# frozen_string_literal: true

# Class that represents the Model for the Log schema
class Log < ApplicationRecord
  belongs_to :user
  belongs_to :loggable, polymorphic: true
end
