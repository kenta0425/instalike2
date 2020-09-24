class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:create, :destroy]
  
  def new
    @post = Post.new
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end
  
  def create
    @post = current_user.posts.build(post_params)
    @post.image.attach(params[:post][:image])
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      # @feed_items = current_user.feed.paginate(page: params[:page])
      render root_url
    end
  end
  
  def destroy
  end
  
  private
  
  def post_params
    params.require(:post).permit(:content, :image)
  end
  
end
