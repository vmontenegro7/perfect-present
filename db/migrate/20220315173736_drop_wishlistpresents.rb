class DropWishlistpresents < ActiveRecord::Migration[6.1]
    def change
      drop_table :wishlist_presents
    end
end
