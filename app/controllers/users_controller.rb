class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  # def logout
  #   link_to 'Sign out', destroy_user_session_path, :method => :delete
  # end
end
