class RegistrationsController < Devise::RegistrationsController

  respond_to :json
  def create
    user = User.new(user_params)
    if User.find_by(:email => user.email)
      binding.pry
      render json: User.find_by(:email => user.email), status: 200, location: [:api, user]
    else
      if user.save
        render json: user, status: 201, location: [:api, user]
      else
        render json: { errors: user.errors }, status: 422
      end
    end

  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end