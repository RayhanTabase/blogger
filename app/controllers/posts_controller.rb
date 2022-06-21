class PostsController < ApplicationController
  def index
    @user = User.includes(posts: [:comments]).find(params[:user_id])
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
  end

  def new
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: post } }
    end
  end

  def create
    post = current_user.posts.new(params.require(:post).permit(:title, :text))
    post.set_defaults
    respond_to do |format|
      format.html do
        if post.save
          redirect_to "/users/#{current_user.id}/posts", flash: { alert: 'Post created successfully' }
        else
          render :new, locals: { post: post }, flash: { alert: 'Error occured' }
        end
      end
    end
  end
end
