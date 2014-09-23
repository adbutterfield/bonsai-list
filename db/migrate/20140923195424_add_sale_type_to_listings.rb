class AddSaleTypeToListings < ActiveRecord::Migration
  def change
    add_column :listings, :sale_type, :string
  end
end
