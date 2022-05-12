class SnippetsController < ApplicationController
    def new
        @snippet = Snippet.new
        @post = Post.find_by(id: params[:post_id])
        if current_user 
            render :new
        else 
            redirect_to post_url(@post)
        end
    end

    def create
        new_snippet_params = snippet_params
        new_snippet_params[:user_id] = current_user.id 
        @snippet = Snippet.new(new_snippet_params)
        @post = Post.find_by(id: new_snippet_params[:post_id])

        if @snippet.save 
            render json: @post 
        else  
            flash.now[:errors] = @snippet.errors.full_messages[0]
            render :new
        end
    end

    private

    def snippet_params
        params.require(:snippet).permit(:post_id, :language, :code)
    end
end
