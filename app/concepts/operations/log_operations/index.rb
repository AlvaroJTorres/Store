module Operations
    module LogOperations
        class Index < Trailblazer::Operation
            step :logs

            def logs(options, **)
                options[:model] = Log.all
            end
        end
    end
end