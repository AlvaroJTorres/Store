# frozen_string_literal: true

module Logs
  # Service Object to List all Logs
  class LogIndexService < ApplicationService
    def call
      Log.all
    end
  end
end
