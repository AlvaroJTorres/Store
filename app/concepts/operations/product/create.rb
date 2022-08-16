module Operations
    module Product
        class Create < Trailblazer::Operation
            pass :new_model
            step :validate_product
            fail :validations_errors!

            def new_model(options, **)
                options[:model] = Product.new
            end

            def validate_product(options, params:, **)
                form = Forms::ProductCreateForm.new(Produt.new)
                form.validate(params)
            end

            def validations_errors(options, **)
                "Errors"
            end

            def save_model(options, params:, **)
                options[:model].attributes = params
                options[:model].save
            end

            def representer(options, model:, **)
                options[:model] = Representers::ProductRepresenter.new(model)
            end
        end
    end
end