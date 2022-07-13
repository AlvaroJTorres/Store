# frozen_string_literal: true

# Class that represents the Model for the Tag schema
class Tag < ApplicationRecord
  has_and_belongs_to_many :products
end
