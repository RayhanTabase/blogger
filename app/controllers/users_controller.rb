class UsersController < ApplicationController
  # before_action :authenticate_user! , only: %i[index create show]
  before_action :set_user, only: %i[index show]

  def index
    render json: { success: 'You are logged in' }
  end

  def show
    json_response(@user.email)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # stores saved user id in a session
      session[:user_id] = @user.id
      render json: { success: 'Account Creation Success' }
    else
      render json: { error: 'Invalid Inputs' }
    end
  end

  # LOGGING IN
  def login
    @user = User.find_by(email: params[:email])
    # finds existing user, checks to see if user can be authenticated
    if @user.present?
      # sets up user sessions
      session[:user_id] = @user.id
      render json: { success: 'You are logged in' }
    else
      render json: { error: 'Invalid username or password' }
    end
  end

  def destroy
    # deletes user session
    session[:user_id] = nil
    render json: { success: 'logged_out' }
  end

  private

  def user_params
    params.permit(:email, :password, :name)
  end

  def set_user
    session_id = session[:user_id]
    @user = User.find(session_id)
  end
end
