class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def new
    @user = User.new
  end
end
