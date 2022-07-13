# frozen_string_literal: true

# Define the Controllers required for the Logs endpoints
class LogsController < ApplicationController
  # Method that responds to the get request to list all the records
  # from the log database
  def index
    @logs = authorize Log.all
  end
end
