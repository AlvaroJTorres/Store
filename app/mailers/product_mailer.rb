# frozen_string_literal: true

# Mailers for Products
class ProductMailer < ApplicationMailer
  def alert_stock_email
    @product = params[:product]
    attachments['product.png'] = { mime_type: 'image/png', content: @product.avatar.download } if @product.avatar.attached?
    @user = @product.likes.last.user
    mail(to: @user.email, subject: 'The stock is running low')
  end
end
