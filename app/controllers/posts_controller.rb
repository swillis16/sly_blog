class PostsController < ApplicationController

authentication_results = http_basic_authenticate_with name: "swillis16", password: "RailsIsGood", except: [:index, :show]

def index
    @posts = Post.all()
end

def new
    @post = Post.new
end

def create 
    @post = Post.new(post_params)
    @post.publish_date = Date.today
    
    if @post.save
        redirect_to @post
    else
        render 'new'
    end
end

def show
    @post = Post.find(params[:id])
end

def update
    @post = Post.find(params[:id])
   
    if params.has_key?(:post)
        @post.publish_date = Date.today
        @post.update(params[:post].permit(:title, :text))
        redirect_to @post
    else
        render 'edit'
    end
end

def edit
    @post = Post.find(params[:id])
end

def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
end

private
    def post_params
        params.require(:post).permit(:title, :text)
    end

end
