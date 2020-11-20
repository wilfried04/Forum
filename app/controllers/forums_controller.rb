class ForumsController < ApplicationController
    before_action :set_forum, only: [:edit, :update, :destroy]

    def index
        @forums = Forum.all
    end
    def new
        @forum = Forum.new    
        autherize?(@forum)
    end

    def edit
    end

    def create
            @forum = Forum.new(forum_params)
        if @forum.save
            flash[:notice]='Forum was successfully created.'
            redirect_to root_url
        else
            flash[:error] = @forum.errors.full_messages.map{|x| "<span>#{x}</span>" }.join('<br/>')
            render :new
        end
    end

    def update
        if @forum.update(forum_params)
        flash[:notice]= 'Forum was successfully updated.'
        redirect_to forums_url(@forum)
        else
        flash[:error] = @forum.errors.full_messages.map{|x| "<span>#{x}</span>" }.join('<br/>')
        render :edit
        end   
    end

    def destroy
        @forum.destroy
        redirect_to forums_url, notice: 'Forum was successfully deleted.'
    end

        private
        def set_forum
            @forum = Forum.find(params[:id])
        autherize?(@forum)
        rescue ActiveRecord::RecordNotFound
            flash[:error] = "Record not found ..!!!"
            redirect_to root_url
        end

        def forum_params
            params.require(:forum).permit(:name, :description, :user_id, :slug)
        end
end
