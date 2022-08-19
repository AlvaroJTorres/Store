# frozen_string_literal: true

module Operations
    module ProductOperations
      class Index < Trailblazer::Operation
        step :products_scope
  
        def products_scope(options, params:, **)
          ordered_by_name = Querys::ProductsQuery.new.order_by_letter(params[:letter])
          ordered_by_likes = Querys::ProductsQuery.new(ordered_by_name).order_by_likes_count(params[:likes_count])
          filter_by_name = Querys::ProductsQuery.new(ordered_by_likes).filter_by_term(params[:term])
          options[:model] = Querys::ProductsQuery.new(filter_by_name).filter_by_tag(params[:tag])
        end
      end
    end
  end