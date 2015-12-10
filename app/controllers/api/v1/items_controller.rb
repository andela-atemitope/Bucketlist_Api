class Api::V1::ItemsController < ApplicationController
  before_action :set_current_user
 
  def index
    bucketlist = @current_user.bucketlists.find_by_id(params[:bucketlist_id])
    @items = bucketlist.items if bucketlist
  end
 
  def new
    respond_with item.find(params[:id])
  end
 
  def create
    bucketlist = @current_user.bucketlists.find_by(id: params[:bucketlist_id])
    @item = bucketlist.items.create(items_params) if (bucketlist && items_params)
    render json: @item
  end
 
  def show
    @bucketlist = @current_user.bucketlists.find_by(id: params[:bucketlist_id])
    @item = @bucketlist.items.find_by_id(params[:id])
    render json: @bucketlist, @item
  end
 
  def update
    @bucketlist = @current_user.bucketlists.find_by_id(params[:bucketlist_id])
    @item = @bucketlist.items.find_by_id(params[:id]) if @bucketlist
    @item.update(items_params) if (@item && items_params)
    render json: @bucketlist, @item
  end
 
  def destroy
    bucketlist = @current_user.bucketlists.find_by_id(params[:bucketlist_id])
    item = bucketlist.items.find_by_id(params[:id]) if bucketlist
    item.destroy if item
    redirect_to api_v1_bucketlist_items_path, status: 303
  end
 
  private
 
  def items_params
    params.require(:item).permit(:name) if params.has_key? "item"
  end
end
