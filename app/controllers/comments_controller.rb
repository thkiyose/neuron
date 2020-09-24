class CommentsController < ApplicationController
  respond_to? :js

  def create
    @contribution = Contribution.find(params[:contribution_id])
    @comment = @contribution.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    @comments = @contribution.comments.all
  end

  private

  def comment_params
    params.require(:comment).permit(:contribution_id, :content)
  end

end
