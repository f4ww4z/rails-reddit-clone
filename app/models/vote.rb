class Vote < ApplicationRecord
  belongs_to :account
  belongs_to :post

  POST_VOTE_KARMA = 2

  # Each account can only make 1 vote to a post
  validates_uniqueness_of :account_id, scope: :post_id

  after_create :increment_vote, :increase_karma
  after_destroy :decrement_vote, :decrease_karma

  private

  def increment_vote
    field = self.upvote ? :upvotes : :downvotes
    Post.find(self.post_id).increment(field).save
  end

  def decrement_vote
    field = self.upvote ? :upvotes : :downvotes
    Post.find(self.post_id).decrement(field).save
  end

  def increase_karma
    account = Account.find(self.account_id)
    account.increment(:karma, POST_VOTE_KARMA).save
  end

  def decrease_karma
    account = Account.find(self.account_id)
    account.decrement(:karma, POST_VOTE_KARMA).save
  end
end
