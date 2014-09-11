class RemoveAddressAndPostcodeFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :address, :string
    remove_column :users, :postcode, :string
  end
end
