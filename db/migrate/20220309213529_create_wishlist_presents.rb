class CreateWishlistPresents < ActiveRecord::Migration[6.1]
  def change
    create_table :wishlist_presents do |t|
      t.references :user, null: false, foreign_key: true
      t.references :present, null: false, foreign_key: true

      t.timestamps
    end
  end
end
