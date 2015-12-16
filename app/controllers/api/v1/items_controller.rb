class Api::V1::ItemsController < ApplicationController
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
    saved_item
  end
 
  def show #show 
    render json: @item
  end
 
  def update #update
    @item.update(items_params) if (@item && items_params)
    render json: @item
  end
 
  def destroy #destroy
    @item.destroy
    render json: {message: "Your Item has been successfully deleted"}, status: 303
  end
 
  private
 
  def items_params
    params.permit(:bucketlist_id, :name, :done) 
  end

  def find_bucketlist
    @bucketlist = @current_user.bucketlists.find_by_id(params[:bucketlist_id])
    render json: { error: "bucketlist not found" }, status: :not_found unless !@bucketlist.nil?
  end

  def set_item
    @item = @bucketlist.items.find_by_id(params[:id])
    render json: { error: "item not found" }, status: :not_found unless !@item.nil?
  end

  def saved_item
    if @item.save
      render json: @item, status: :created
    else
      render json:  @item.errors.full_messages, status: 400
    end
  end
end
