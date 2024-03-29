class ForumsController < ApplicationController
    before_action :authenticate_user!

    def index
        @forums = policy_scope(Forum)
    end

    def new
        @forum = Forum.new
        authorize @forum
    end

    def create
        @forum = Forum.new(forum_params)
        authorize @forum

        if @forum.save
            redirect_to :action => 'index'
        else
            render :action => 'new'
        end
    end

    def edit
        @forum = Forum.find(params[:id])
        authorize @forum
    end

    def update
        @forum = Forum.find(params[:id])
        authorize @forum

        if @forum.update_attributes(forum_params)
            redirect_to :action => 'index'
        else
            render :action => 'edit'
        end
    end

    def show
        @forum = Forum.find(params[:id])
        @boards = Board.where(forum_id: @forum.id)
        @boards = @boards.order(:name)
    end

    def destroy
        @forum = Forum.find(params[:id])
        @forum.destroy

        redirect_to action: 'index'
    end

    def academics
    	@posts = Post.last(5).reverse
    	@boards = Board.all
    	@boards = @boards.order(:name)
    end

    private

        def forum_params
          params.require(:forum).permit(:name, :description)
        end
end
