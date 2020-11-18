class TopicsController < ApplicationController
    before_action :set_topic, only: [:show, :edit, :update, :destroy]
    def index
        @topics= Topic.all
        #@user = User.all
    end
    def new
        @Topic = Topic.new
    end

    def create
        @topic=Topic.new(topic_params)
        @topic=current_user.topics.build(topic_params)
        if params[:back]
            render :new
        else
            if @topic.save
                TopicMailer.contact_mail(@topic).deliver
                flash[:success] = 'Post successfully create'
                redirect_to topics_path
            else
                render :new
            end
        end
    end
    def edit
    end
    def show
        @favorite = current_user.favorites.find_by(topic_id: @topic.id)
    end
    def update
            if @topic.update(topic_params)
                flash[:success] = 'Post successfully update'
                redirect_to topics_path
            else
             render :edit
            end
    end
    def destroy
        @topic.destroy
        flash[:success] = 'Post successfully destroy'
        redirect_to topics_path
    end
    def confirm
        @topic=Topic.new(topic_params)
        @topic = current_user.topics.build(topic_params)
        render :new if @topic.invalid?
    end
    private
    def topic_params
        params.require(:topic).permit(:content,:image,:image_cache)
    end
    def set_topic
            @topic=Topic.find(params[:id])
    end
    
end