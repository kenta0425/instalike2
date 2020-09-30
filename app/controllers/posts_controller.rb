class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :correct_user,   only: :destroy
  
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
      render root_url
    end
  end
  
  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end
  
  private
  
  def post_params
    params.require(:post).permit(:content, :image)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
  
end
