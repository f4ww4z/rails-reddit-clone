class VotesController < ApplicationController
  before_action :authenticate_account!

  def create
    post_id = params[:post_id]
    vote = Vote.new
    vote.post_id = post_id
    vote.upvote = params[:upvote]
    vote.account_id = current_account.id

    # check if vote by this exists
    existing_vote = Vote.where(account_id: current_account.id, post_id: post_id)

    respond_to do |format|
      format.js {
        if existing_vote.size.positive?
          # destroy existing vote
          existing_vote.first.destroy
        else
          @success = vote.save
        end

        @post = Post.find(post_id)
        @is_upvote = params[:upvote] == 'true'

        render 'votes/create'
      }
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:upvote, :post_id)
  end
end
