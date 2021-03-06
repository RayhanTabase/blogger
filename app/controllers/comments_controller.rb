class CommentsController < ApplicationController
  # load_and_authorize_resource

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params.require(:comment).permit(:text))
    @comment.author_id = current_user.id

    respond_to do |format|
      format.html do
        if @comment.save
          redirect_to user_post_path(current_user, @post), flash: { alert: 'Comment created successfully' }
        else
          render :new, locals: { comment: @comment }, flash: { alert: 'Error: Comment could not be created' }
        end
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:comment_id])
    @comment.destroy
    respond_to do |format|
      format.html do
        redirect_to user_post_path(current_user, @post), flash: { alert: 'Comment deleted' }
      end
    end
  end
end
