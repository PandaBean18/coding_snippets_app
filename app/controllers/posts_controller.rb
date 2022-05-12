class PostsController < ApplicationController
    def show
        @post = Post.find_by(id: params[:id])
        if @post 
            render :show
        else  
            redirect_to user_url(current_user)
        end
    end

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
            redirect_to "/posts/#{@post.id}/snippets/new"
        else
            flash.now[:errors] = @post.errors.full_messages[0]
            render :new
        end
    end

    def edit
        @post = Post.find_by(id: params[:id]) # change to redirect to posts or /home if @post is nil
        if current_user
            render :edit
        else
            redirect_to new_session_url
        end
    end

    def update
        id = edit_post_params[:id]
        @post = Post.find_by(id: id)
        if @post.update(post_params)
            redirect_to post_url(@post)
        else
            flash.now[:errors] = @post.errors.full_messages[0]
            render :edit
        end
    end

    def destroy
        @post = Post.find_by(id: params[:id])

        @post ? @post.destroy : nil

        redirect_to user_url(current_user)
    end

    private

    def post_params
        params.require(:post).permit(:heading, :description, :snippet)
    end

    def edit_post_params
        params.require(:post).permit(:id, :heading, :description, :snippet)
    end
end
