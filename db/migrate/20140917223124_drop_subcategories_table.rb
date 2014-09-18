class DropSubcategoriesTable < ActiveRecord::Migration
  def change
    drop_table :subcategories
  end
end
