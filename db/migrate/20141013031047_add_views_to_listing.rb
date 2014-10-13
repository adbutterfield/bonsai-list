class AddViewsToListing < ActiveRecord::Migration
  def change
    add_column :listings, :views, :integer, default: 0
  end
end
