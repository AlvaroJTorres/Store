# frozen_string_literal: true

# Define the Controllers required for the Logs endpoints
class TransactionsController < ApplicationController
  # Method that responds to the get request to list all the records
  # from the log database
  def index
    @transactions = authorize Transactions::TransactionIndexService.call(current_user)
  end
end
