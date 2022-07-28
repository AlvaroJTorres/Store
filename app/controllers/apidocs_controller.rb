# frozen_string_literal: true

# Controller for displaying documentation for Apidocs
class ApidocsController < ActionController::Base
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Snack Store'
      key :description, 'A sample API that calls endpoints for a snack store ' \
                        'to list products and add orders'
      key :termsOfService, 'http://helloreverb.com/terms/'
      contact do
        key :name, 'Alvaro Torres'
      end
    end
    key :basePath, '/api/v1'
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
    ProductsControllerDocs,
    ProductDocs,
    OrderLinesControllerDocs,
    OrderLineDocs,
    LikesControllerDocs,
    LikeDocs,
    self
  ].freeze

  def index; end

  def json
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end
