# frozen_string_literal: true

# Controllers for Logs
class LogsController < ApplicationController
  def index
    @logs = authorize Log.all
  end
end
