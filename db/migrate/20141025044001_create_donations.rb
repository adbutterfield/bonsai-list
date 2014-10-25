class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.references :user, index: true
      t.integer :amount

      t.timestamps
    end
  end
end
