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
        @comment = Comments::ApiCommentCreatorService.call(comment_params, @commentable, current_user)

        if @comment
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :bad_request
        end
      end

      # Method that responds to the update request for a comment
      def update
        updated_comment = Comments::ApiCommentUpdaterService.call(@comment)

        render json: updated_comment
      end

      # Method that responds to the destroy request for a comment
      def destroy
        Comments::CommentDestroyService.call(@comment)
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
