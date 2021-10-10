class PublicController < ApplicationController
  def index
    @communities = Community.all.limit(5)
    @posts = Post.limit(20).sort_by(&:score).reverse
  end

  def profile
    @profile = Account.find_by_username params[:username]
    @posts = Post.where account_id: @profile.id
  end
end