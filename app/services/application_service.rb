# frozen_string_literal: true

# Class that abstracts the call method and inherits to every service object
class ApplicationService
  def self.call(*args)
    new(*args).call
  end
end
