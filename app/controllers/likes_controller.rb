class LikesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new
    @like.author_id = current_user.id

    respond_to do |format|
      format.html do
        redirect_to user_post_path(current_user, @post), flash: { alert: 'Success' } if @like.save
      end
    end
  end
end
