class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: post } }
    end
  end

  def create
    post = current_user.posts.new(params.require(:post).permit(:title, :text))
    respond_to do |format|
      format.html do
        if post.save
          flash[:success] = 'Post created successfully'
          redirect_to "/users/#{current_user.id}/posts"
        else
          flash.now[:error] = 'Error: Post could not be created'
          render :new, locals: { post: post }
        end
      end
    end
  end
end
