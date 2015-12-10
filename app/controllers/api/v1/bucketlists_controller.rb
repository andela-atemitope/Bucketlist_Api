class Api::V1::BucketlistsController < ApplicationController
  before_action :set_current_user
 
  def index
    @bucketlists = @current_user.bucketlists.includes(:items)
    render json: @bucketlists
  end
 
  def create
    @bucketlist = @current_user.bucketlists.create(bucketlist_params) if bucketlist_params
    render json: @bucketlist
  end
 
  def show
    @bucketlist = @current_user.bucketlists.includes(:items).find_by(id: params[:id])
    render json: @bucketlist
  end
 
  def update
    @bucketlist = @current_user.bucketlists.includes(:items).find_by(id: params[:id])
    @bucketlist.update(bucketlist_params) if (@bucketlist && bucketlist_params)
    render json: @bucketlist
  end
 
  def destroy
    @bucketlist = @current_user.bucketlists.find_by_id(params[:id])
    @bucketlist.destroy if @bucketlist
    redirect_to api_v1_bucketlists_path, status: 303
  end
 
  private
 
  def bucketlist_params
    params.require(:bucketlist).permit(:name) if params.has_key? "bucketlist"
  end
end

