class WishlistsController < ApplicationController
  before_action :set_wish_list_item, only: %i[destroy]
def index
    # @wishlist_items = Wishlist.all
    @wishlist_items = Wishlist.all
    @presents = Present.all
    @my_wishlist_items = @wishlist_items.select do |wishlist_item|
      current_user.id == wishlist_item.user_id
    end
    @my_presents = @presents.select do |present|
      @my_wishlist_items.each do |my_wishlist_item|
        my_wishlist_item.present_id == present.id
      end
      
    end
  end

  def new
    #@wishlist_item = Wishlist.new
    # authorize @wishlist_item
  end

  def create
    @wishlist_item = Wishlist.create(user_id: current_user.id, present_id: wishlist_item_params) # (present_id: wishlist_item_params)
    #@wishlist_item.present_id = wishlist_item_params
    #@wishlist_item.user_id = current_user.id
    # authorize @wishlist_item
    if @wishlist_item.save!
      redirect_to wishlists_path, notice: 'Item has been wishlisted!.'
    else
      redirect_to root_path, notice: 'Something went wrong!'
    end
  end

  def destroy
    # authorize @wishlist_item
    @wishlist_item.destroy
    redirect_to presents_path, notice: 'Item has been successufuly removed from your wishlist!'
  end

  private

  def wishlist_item_params
    params.require(:present_id)
  end

  def set_wish_list_item
    @wishlist_item = Wishlist.find(params[:id])
  end
end