class AddMainPicIdToListings < ActiveRecord::Migration
  def change
    add_column :listings, :main_image_id, :integer
  end
end
