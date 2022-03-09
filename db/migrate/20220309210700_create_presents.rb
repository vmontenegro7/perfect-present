class CreatePresents < ActiveRecord::Migration[6.1]
  def change
    create_table :presents do |t|
      t.string :category
      t.float :price
      t.string :image_url
      t.string :item_url
      t.text :description
      t.string :name
      t.integer :rating

      t.timestamps
    end
  end
end
