# frozen_string_literal: true

module Operations
  module LogOperations
    # Operation to index logs
    class Index < Trailblazer::Operation
      step :logs

      def logs(options, **)
        options[:model] = Log.all
      end
    end
  end
end
