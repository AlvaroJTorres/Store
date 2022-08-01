# frozen_string_literal: true

# Representable decorator for Comment JSON
class CommentRepresenter < Representable::Decorator
  include Representable::JSON

  property :id
  property :body
  property :rate
  property :user_id
  property :approved
  property :comment_author, exec_context: :decorator

  def comment_author
    represented.commentable.first_name
  end
end
