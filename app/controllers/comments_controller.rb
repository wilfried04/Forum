class CommentsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.new(comment_params)
    if @comment.save
      redirect_to topic_path(@topic)
    else
      @comments = @topic.comments.includes(:topic)
      flash[:danger] = "Failed to send"
      render("topics/show")
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:name, :text).merge(user_id: current_user.id)
  end
end
