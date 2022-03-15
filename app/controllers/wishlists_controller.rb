class WishlistsController < ApplicationController

  def index
    # @wishlist_items = Wishlist.all
    @wishlist_items = Wishlist.all
  end

  def new
  end

  def create
    @wishlist_item = Wishlist.new(wishlist_item_params)
    @wishlist_item.save!
    redirect_to wishlists_path
  end

  def destroy
    @wishlist_item = Wishlist.find(params[:id])
    @wishlist_item.destroy
    authorize @wishlist_item
  end
  def wishlist_item_params
    params.require(:wishlist).permit(:user_id, :present_id)
  end
end
