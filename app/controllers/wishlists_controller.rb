class WishlistsController < ApplicationController
  before_action :set_wish_list_item, only: %i[destroy]
  def index
    # @wishlist_items = Wishlist.all
    @wishlist_items = Wishlist.all
    # @presents = Present.all
    @my_wishlist_items = @wishlist_items.select do |wishlist_item|
      current_user.id == wishlist_item.user_id
    end
    @my_wishlist_items_final = @my_wishlist_items.collect do |wishlist_item|
      request_api(wishlist_item.api_id)
    end
    # @my_presents = @presents.select do |present|
    #   @my_wishlist_items.each do |my_wishlist_item|
    #     my_wishlist_item.present_id == present.id
    #   end
    # end
  end

  def new
    #@wishlist_item = Wishlist.new
    # authorize @wishlist_item
  end

  def create
    @wishlist_item = Wishlist.create(user_id: current_user.id, api_id: wishlist_item_params) # (present_id: wishlist_item_params)
    #@wishlist_item.present_id = wishlist_item_params
    #@wishlist_item.user_id = current_user.id
    # authorize @wishlist_item
    if @wishlist_item.save
      redirect_to wishlists_path, notice: 'Item has been wishlisted!.'
    else
      redirect_to pages_path, notice: 'Something went wrong!'
    end
  end

  def destroy
    # authorize @wishlist_item
    @my_wishlist_item_to_delete.destroy
    redirect_to wishlists_path, notice: 'Item has been successufuly removed from your wishlist!'
  end

  private

  def wishlist_item_params
    params.require(:api_id)
  end

  def set_wish_list_item
    @api_id = params[:id].split("&")[0].split("=")[1]
    @user_id = params[:id].split("&")[1].split("=")[1].to_i
    @my_wishlist_items = Wishlist.where(["user_id = ?", @user_id])
    @my_wishlist_item_to_delete = @my_wishlist_items.where(["api_id = ?", @api_id])
    # raise
    # @wishlist_item = Wishlist.find(params[:id])# Wishlist.find(params[:id])
    @my_wishlist_item_to_delete = @my_wishlist_item_to_delete[0]
    # @wishlist_item = Wishlist.find(params[:id])
  end

  def request_api(item_id)
    url = "https://api.mercadolibre.com/items/#{item_id}"
    product_serialized = URI.open(url).read
    JSON.parse(product_serialized)
  end

  def request_module
    require 'open-uri'
  end
end
