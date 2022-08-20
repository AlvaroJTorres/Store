# frozen_string_literal: true

module Api
  module V1
    # Define the Controllers required for the Comments endpoints
    class CommentsController < ApiController
      before_action :pundit_authorize
      before_action :set_commentable
      before_action :set_comment, only: %i[update destroy]

      # Method that responds to the create request for a new comment
      def create
        result = Operations::CommentOperations::ApiCreate.call(params: comment_params, commentable: @commentable,
                                                               user: current_user)
        render json: { data: { comment: result[:model] } }, status: :created
      end

      # Method that responds to the update request for a comment
      def update
        result = Operations::CommentOperations::ApiUpdate.call(params: params[:id], commentable: @commentable)
        render json: { data: { comment: result[:model] } }
      end

      # Method that responds to the destroy request for a comment
      def destroy
        Operations::CommentOperations::ApiDelete.call(params: params[:id], commentable: @commentable)
        render body: nil, status: :no_content
      end

      private

      def comment_params
        params.require(:comment).permit(:body, :rate)
      end

      def pundit_authorize
        authorize Comment
      end

      def set_commentable
        @commentable = Users::UserFinderService.call(params[:user_id])
      end

      def set_comment
        @comment = Comments::CommentFinderService.call(@commentable, params[:id])
      end
    end
  end
end
