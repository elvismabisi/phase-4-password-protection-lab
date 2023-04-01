class UsersController < ApplicationController
    def create
        if(params[:password] != params[:password_confirmation])
            render json: { error: "Password do not match" }, status: :unprocessable_entity
        else
            user = User.create(user_params)
            session[:user_id] = user.id
            render json: user
        end
    end

    def show
        user = User.find_by(id: session[:user_id])
        if user
            render json: user
        else
            render json: { error: "Not authorized" }, status: :unauthorized
        end
    end

    private

    def user_params
        params.permit(:username, :password)
    end
end
