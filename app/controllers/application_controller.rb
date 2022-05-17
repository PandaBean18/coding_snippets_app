class ApplicationController < ActionController::Base
    helper_method :current_user

    def current_user
        return nil if session[:session_token].nil?
        user = User.find_by(session_token: session[:session_token])
        return user
    end

    def log_user_in!(user)
        session[:session_token] = user.reset_session_token!
    end
end
