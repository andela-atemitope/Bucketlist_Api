module Api
  module V1
    class ItemsController < ApplicationController
      before_action :set_current_user, :find_bucketlist
      before_filter :set_item, only: [:show, :update, :destroy]

      def index
        @items = @bucketlist.items
        render json: @items
      end

      def new
        respond_with item.find(params[:id])
      end

      def create
        @item = @bucketlist.items.new(items_params)
        saved_item(@item)
      end

      def show
        render json: @item
      end

      def update
        @item.update(items_params) if @item && items_params
        render json: @item
      end

      def destroy
        @item.destroy
        render json: { message: "Your Item has been deleted" },
        status: 303
      end

      private

      def items_params
        params.permit(:bucketlist_id, :name, :done)
      end

      def find_bucketlist
        @bucketlist = @current_user.bucketlists.find_by_id(params[:bucketlist_id])
        if @bucketlist.nil?
          render json: { error: "bucketlist not found" }, status: :not_found
        end
      end

      def set_item
        @item = @bucketlist.items.find_by_id(params[:id])
        if @item.nil?
          render json: { error: "item not found" }, status: :not_found
        end
      end

      def saved_item(item)
        if item.save
          render json: item, status: :created
        else
          render json:  item.errors.full_messages, status: 400
        end
      end
    end
  end
end
