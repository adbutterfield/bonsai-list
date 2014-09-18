class RemoveSubcategoryIdFromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :subcategory_id, :string
  end
end
