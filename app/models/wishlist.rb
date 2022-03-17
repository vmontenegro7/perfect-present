class Wishlist < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :api_id, scope: :user_id
end
