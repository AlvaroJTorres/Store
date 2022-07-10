# frozen_string_literal: true

# Model for Tag
class Tag < ApplicationRecord
  has_and_belongs_to_many :products
end
