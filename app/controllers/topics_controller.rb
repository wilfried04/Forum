class TopicsController < ApplicationController
  def index
    @topics = Topic.all.order(created_at: :desc)
    @topic = Topic.new
    @categories = Category.all
  end

  def new
    @topic = Topic.new
  end

  def show
    @topic = Topic.find(params[:id])
    @comments = @topic.comments.includes(:topic)
    @comment = Comment.new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      redirect_to topic_path(@topic)
    else
      @topics = Topic.all
      @categories = Category.all
      flash.now[:alert] = "Failed to create"
      render :index
    end
  end

  def search
    relation = Topic.includes(:comments)
    @topics = relation.where("title LIKE?", "%#{params[:keyword]}%").references(:comments).or(relation.where("text LIKE?", "%#{params[:keyword]}%")).order(created_at: :desc)
    @categories = Category.all
  end

  private
  def topic_params
    params.require(:topic).permit(:name, :title, category_ids: []).merge(user_id: current_user.id)
  end
  def topic_params
    params.permit(:topic => [])
  end
end
