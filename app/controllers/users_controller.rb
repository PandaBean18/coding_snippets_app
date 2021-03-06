class UsersController < ApplicationController
    def new
        if current_user
            redirect_to user_url(current_user)
        else
            render :new
        end
    end

    def create
        @user = User.new(user_params)

        if @user.save
            self.log_user_in!(@user)
            redirect_to "/home"
        else
            flash.now[:errors] = @user.errors.full_messages[0]
            render :new
        end
    end

    def show
        @user = User.find_by(id: params[:id])
        if @user
            render :show
        else
            redirect_to new_session_url
        end
    end

    def destroy
        current_user.destroy
        redirect_to new_user_url
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
