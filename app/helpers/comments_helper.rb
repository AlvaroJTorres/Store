# frozen_string_literal: true

# Helpers for Comments views
module CommentsHelper
  def comment_approve_link(commentable, comment)
    case commentable.class.to_s
    when 'Product'
      button_to 'Approve Comment', product_comment_path(commentable, comment), { method: :patch, class: button_style }
    when 'Order'
      button_to 'Approve Comment', order_comment_path(commentable, comment), { method: :patch, class: button_style }
    end
  end

  def comment_delete_link(commentable, comment)
    case commentable.class.to_s
    when 'Product'
      link_to 'Delete Comment', product_comment_path(commentable, comment), { method: :delete, class: button_style }
    when 'Order'
      link_to 'Delete Comment', order_comment_path(commentable, comment), { method: :delete, class: button_style }
    end
  end
end
