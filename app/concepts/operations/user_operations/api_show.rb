# frozen_string_literal: true

module Operations
  module UserOperations
    # Operation to show Users on API
    class ApiShow < Trailblazer::Operation
      pass :find_user
      step :representer

      def find_user(options, params:, **)
        options[:model] = User.find_by(id: params)
      end

      def representer(options, model:, **)
        options[:model] = Representers::UserRepresenter.new(model)
      end
    end
  end
end
