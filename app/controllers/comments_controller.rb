class CommentsController < ApllicationController

  def create
     @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build(params[:comment])
    @comment.post = @post
    @new_comment = Comment.new
  end
  