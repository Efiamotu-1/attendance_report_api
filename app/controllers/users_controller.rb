class UsersController < ApplicationController

    def index
        render json: User.all.count
    end

    def signup
        @user = User.create(user_params)
        if @user.save
            token = encode_token({user_id: @user.id})
            time = Time.now + 24.hours.to_i
            render json: { token: token, name: @user.name, status: :ok }
          else
            render json: { error: 'Invalid Details', error_message: @user.errors }, status: :unauthorized
          end
    end

    def login
        @user = User.find_by(email: user_params[:email])
        if @user && @user.authenticate(user_params[:password])
            token = encode_token({user_id: @user.id})
            time = Time.now + 24.hours.to_i
            render json: { token: token, name: @user.name, id: @user.id, status: :ok}
        else
            render json: { error: "Invalid Username or Password" }, status: :unauthorized
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end