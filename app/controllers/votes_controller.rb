class VotesController < ApplicationController
  before_filter :setup

  private

  def setup
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    authorize! :create, Vote, message: "You need to be a user to do that."

    @vote = @post.votes.where(user_id: current_user.id).first
  end

  def update_vote(new_value)
    if @vote # if it exists, update it
      @vote.update_attribute(:value, new_value)
    else # create it
      @vote = current_user.votes.create(value: new_value, post: @post)
    end
  end

  def up_vote
    update_vote(-1)
    redirect_to :back
    # Just like other controllers, grab the parent objects
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    # Look for an existing vote by this person so we don't create multiple
    @vote = @post.votes.where(user_id: current_user.id).first

    if @vote # if it exists, update it
      @vote.update_attribute(:value, 1)
    else # create it
      @vote = current_user.votes.create(value: 1, post: @post)
    end
    def down_vote
      update_vote(-1)
      redirect_to :back
    end

    redirect_to :back
  end
end