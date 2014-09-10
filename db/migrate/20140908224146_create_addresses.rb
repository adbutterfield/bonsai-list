class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :state
      t.string :postcode
      t.string :country
      t.references :user, index: true

      t.timestamps
    end
  end
end
