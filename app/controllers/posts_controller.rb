class PostsController < ApplicationController
    def new
        if current_user
            render :new
        else
            redirect_to new_session_url
        end
    end

    def create
        new_post_params = post_params
        new_post_params[:user_id] = current_user.id
        @post = Post.new(new_post_params)

        if @post.save
            render json: @post
        else
            flash.now[:errors] = @post.errors.full_messages[0]
            render :new
        end
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def post_params
        params.require(:post).permit(:heading, :description, :snippet)
    end
end
