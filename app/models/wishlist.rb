class Wishlist < ApplicationRecord
  belongs_to :user
  belongs_to :present
end
