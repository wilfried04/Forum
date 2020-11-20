class CommentsController < ApplicationController
  before_action :set_topic, only: %i[create edit update destroy]
  def create
    @comment = @topic.comments.build(comment_params)
    respond_to do |format|
      if @topic.save
        format.js { render :index }
      else
        format.html { redirect_to topic_path(@topic), notice: "This is not post!!!" }
      end
    end
  end

  def edit
    @comment = @topic.comments.find(params[:id])
    respond_to do |format|
      flash.now[:notice] = 'Edit comment!!!'
      format.js { render :edit }
    end
  end

  def update
    @comment = @startup.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        flash.now[:notice] = 'Your comment Update!!!'
        format.js { render :index }
      else
        flash.now[:notice] = 'Your comment not Update!!!'
        format.js { render :edit_error }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      flash.now[:notice] = 'Comment deleted'
      format.js { render :index }
    end
 end

  private

  def comment_params
    params.require(:comment).permit(:topic_id, :description)
  end

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end


end
