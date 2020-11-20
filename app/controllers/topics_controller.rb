class TopicsController < ApplicationController
    before_action :set_topic, only: [:show, :edit, :update, :destroy]
    before_action :find_forum
  
    def index
      @topics = @forum.topics.paginate(:page=>params[:page],:per_page => 5)    
    end
  
    def show
    end
  
    def new
      @topic = Topic.new
      autherize?(@topic)
    end
  
    def edit
      autherize?(@topic)
    end
  
    def create    
      @topic = Topic.new(topic_params)    
      if @topic.save
        flash[:notice] = 'Topic was successfully created.'
        redirect_to forum_topics_url(@forum)
      else
        flash[:error] = @topic.errors.full_messages.map{|x| "<span>#{x}</span>" }.join('<br/>')
        render :new
      end    
    end
  
    def update
      if @topic.update(topic_params)
        flash[:notice]= 'Topic was successfully updated.'
        redirect_to forum_topics_url(@forum)
      else
        flash[:error] = @topic.errors.full_messages.map{|x| "<span>#{x}</span>" }.join('<br/>')
        render :edit
      end    
    end
  
    def destroy
      autherize?(@topic)
      if @topic.destroy
        flash[:notice] = 'Topic was successfully deleted.'
        redirect_to forum_topics_url
      else
        flash[:error] = 'Topic deleted failed.'
        redirect_to root_url
      end    
    end
  
    private
      
      def set_topic
        @topic = Topic.find(params[:id])      
        rescue ActiveRecord::RecordNotFound
          flash[:error] = "Record not found ..!!!"
          redirect_to root_url
      end
  
      def find_forum
        @forum = Forum.find(params[:forum_id])
      end
      
      def topic_params
        params.require(:topic).permit(:name, :description, :slug, :forum_id,:tag_list)
      end
end
