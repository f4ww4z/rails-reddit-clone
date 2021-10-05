class PostsController < ApplicationController
  before_action :authenticate_account!, except: [:index, :show]
  before_action :set_post, only: [:show]

  def index
    @posts = Post.all
  end

  def show
    @community = Community.find(params[:community_id])
    @post = @community.posts.find(params[:id])
  end

  def new
    @community = Community.find(params[:community_id])
    @post = Post.new
  end

  def create
    @community = Community.find(params[:community_id])
    @post = @community.posts.create(post_params)
    @post.account_id = current_account.id

    if @post.save
      redirect_to community_path(@community)
    else
      render :new
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
