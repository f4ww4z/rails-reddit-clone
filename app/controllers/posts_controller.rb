class PostsController < ApplicationController
  before_action :authenticate_account!, except: [:index, :show]
  before_action :auth_subscriber, only: [:new]

  def index
    redirect_to community_path(params[:community_id])
  end

  def show
    @community = Community.find(params[:community_id])
    @post = Post.includes(:comments).find(params[:id])
    @comment = Comment.new
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

  def auth_subscriber
    unless Subscription.where(community_id: params[:community_id], account_id: current_account.id).any?
      redirect_to community_path(params[:community_id]), flash: { danger: "You are not authorized to view this page" }
    end
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
