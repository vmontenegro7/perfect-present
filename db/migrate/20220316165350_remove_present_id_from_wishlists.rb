class RemovePresentIdFromWishlists < ActiveRecord::Migration[6.1]
  def change
    remove_reference :wishlists, :present, index: true, foreign_key: true
  end
end
