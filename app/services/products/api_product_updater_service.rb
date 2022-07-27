# frozen_string_literal: true

module Products
  # Service Object to Update a Product on API
  class ApiProductUpdaterService < ProductUpdaterService
    private

    def update
      @product.changed_by = @user

      @product.update(@params)

      ProductRepresenter.new(@product)
    end
  end
end
