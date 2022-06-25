class PostsController < ApplicationController
  before_action :set_user

  def index
    @posts = @user.posts.includes(:comments)
    render json: @posts
  end

  def show
    @post = @user.posts.find(params[:id])
    render json: @post
  end

  def create
    @post = @user.posts.new(params.require(:post).permit(:title, :text))
    @post.set_defaults
    if @post.save
      json_response(@post, :created)
    else
      render json: { error: 'Invalid post' }
    end
  end

  private

  def set_user
    session_id = session[:user_id]
    @user = User.find(session_id)
  end
end
