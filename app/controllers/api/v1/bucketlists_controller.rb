module Api
  module V1
    class BucketlistsController < ApplicationController
      before_action :set_current_user

      def index
        limit_set = Pagination.set_limit(params[:limit])
        if params[:q]
          display_result = Bucketlist.search_result(@current_user.id, params[:q])
          result = Pagination.paginate(display_result, limit_set, params[:page])
        else
          bucketlist = @current_user.bucketlists
          result = Pagination.paginate(bucketlist, limit_set, params[:page])
        end
        render json: result
      end

      def create
        @bucketlist = @current_user.bucketlists.create(name: params[:name])
        render json: { success: "#{params[:name]} Bucketlist created!" },
        status: :created if error_message
      end

      def show
        @bucketlist = Bucketlist.check_user_list(@current_user.id, params[:id])
        default_message
      end

      def update
        @bucketlist = @current_user.bucketlists.find_by_id(params[:id])
        @bucketlist.update(name: params[:name]) if @bucketlist
        default_message if error_message
      end

      def destroy
        @bucketlist = @current_user.bucketlists.find_by_id(params[:id])
        @bucketlist.destroy if @bucketlist
        render json: { message: "your bucketlist has been deleted" },
        status: 303
      end

      private

      def bucketlist_params
        params.require(:bucketlist).permit(:name, :q, :limit, :page)
      end

      def default_message
        if !@bucketlist.nil? && !@bucketlist.blank?
          render json: @bucketlist
        else
          render json: { error: "selected bucketlist does not exist " }
        end
      end

      def error_message
        error = @bucketlist.errors.full_messages unless @bucketlist.nil?
        if error.empty?
          true
        else
          render json: error
          false
        end
      end
    end
  end
end
