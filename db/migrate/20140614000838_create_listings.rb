class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.string :location
      t.boolean :shippable
      t.boolean :publish
      t.boolean :remove, default: false

      t.references :user, index: true
      t.references :category, index: true
      t.references :subcategory, index: true

      t.timestamps
    end
  end
end
