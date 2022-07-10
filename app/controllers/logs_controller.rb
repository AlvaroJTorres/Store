class LogsController < ApplicationController
  def index
    @logs = authorize Log.all
  end
end
