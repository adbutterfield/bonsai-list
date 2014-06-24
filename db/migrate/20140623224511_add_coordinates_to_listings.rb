class AddCoordinatesToListings < ActiveRecord::Migration
  def change
    add_column :listings, :latitude, :float
    add_column :listings, :longitude, :float

    add_index :listings, [:latitude, :longitude]
  end
end
