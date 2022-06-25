class UsersController < ApplicationController
  # before_action :authenticate_user!
  before_action :authorized, only: [:auto_login]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  # LOGGING IN
  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end

  def auto_login
    render json: @user
  end
end
