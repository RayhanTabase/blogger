class CommentsController < ApplicationController
  before_action :set_user

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    render json: @comments
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params.require(:comment).permit(:text))
    current_user = User.first
    @comment.author_id = current_user.id
    if @comment.save
      render json: @post
    else
      render json: { alert: 'Error: Comment could not be created' }
    end
  end

  private

  def set_user
    session_id = session[:user_id]
    @user = User.find(session_id)
  end
end
