# frozen_string_literal: true

# Define the Controllers required for the Logs endpoints
class LogsController < ApplicationController
  # Method that responds to the get request to list all the records
  # from the log database
  def index
    result = Operations::LogOperations::Index.call(params: {})
    @logs = authorize result[:model]
  end
end
