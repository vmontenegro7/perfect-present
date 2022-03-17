class AddApiIdToWishlists < ActiveRecord::Migration[6.1]
  def change
    add_column :wishlists, :api_id, :string
  end
end
