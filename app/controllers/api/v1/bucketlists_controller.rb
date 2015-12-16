class Api::V1::BucketlistsController < ApplicationController
  before_action :set_current_user
 
  def index
    if params[:q]
      display_result =  Bucketlist.search_result(@current_user.id, params[:q])
      limit_set = set_limit(params[:limit])
      paginate(display_result, limit_set, params[:page])
    else
      bucketlist = @current_user.bucketlists
      limit_set = set_limit(params[:limit])
      paginate(bucketlist, limit_set, params[:page])
     end
  end
 
  def create
    @bucketlist = @current_user.bucketlists.create(name: params[:name])
    render json: { success: "#{params[:name]} Bucketlist created!" }, status: :created if error_message
  end
 
  def show
    @bucketlist = @current_user.bucketlists.includes(:items).find_by(id: params[:id])
    default_message
  end
 
  def update
    @bucketlist = @current_user.bucketlists.find_by(id: params[:id])
    @bucketlist.update(name: params[:name]) if @bucketlist
    render json: @bucketlist if error_message
  end
 
  def destroy
    @bucketlist = @current_user.bucketlists.find_by_id(params[:id])
    @bucketlist.destroy if @bucketlist
    render json: {message: "your bucketlist and its items have been deleted"}, status: 303
  end

  def set_limit(limit)
    case 
      when limit.nil? || limit.to_i < 0
        20
      when limit.to_i > 100
        100
      else
        limit.to_i
    end
  end

  def paginate(search_result, limit = nil, pages = nil)
    total_items = limit.to_i * pages.to_i
    offset = total_items - limit.to_i 
    display = search_result.limit(limit).offset(offset)
    result_message(display)
  end

 
  private
 
  def bucketlist_params
    params.require(:bucketlist).permit(:name, :q, :limit, :page) #if params.has_key? "bucketlist"
  end

  def result_message(result) 
    if result.empty?
      render json: { error: "no results found for search query" }
    else      
      render json: result
    end
  end 

  def default_message 
    if !@bucketlist.nil? && !@bucketlist.blank?
      render json: @bucketlist
    else 
      render json: { error: "selected bucketlist does not exist " }
    end
  end


  def error_message
    error = @bucketlist.errors.full_messages
    if error.empty?
      true
    else 
      render json: error
      false
    end
  end
end

