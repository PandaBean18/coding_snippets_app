class SessionsController < ApplicationController
    def new
        if current_user
            redirect_to user_url(current_user)
        else
            render :new
        end
    end

    def create
        @user = User.find_by_credentials(session_params[:username], session_params[:password])

        if @user
            session[:session_token] = @user.reset_session_token!
            render json: session
        else
            flash.now[:errors] = 'Invalid credentials.'
            render :new
        end
    end

    def destroy
        current_user.reset_session_token!
        session[:session_token] = nil
        redirect_to new_session_url
    end

    private

    def session_params
        params.require(:user).permit(:username, :password)
    end
end
