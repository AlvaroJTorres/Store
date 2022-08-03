# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/product_mailer
class ProductMailerPreview < ActionMailer::Preview
  def alert_stock_email
    ProductMailer.with(product: Product.find(15)).alert_stock_email
  end
end
