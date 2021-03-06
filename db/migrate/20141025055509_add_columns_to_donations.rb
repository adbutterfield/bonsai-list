class AddColumnsToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :notification_params, :text
    add_column :donations, :status, :string
    add_column :donations, :transaction_id, :string
    add_column :donations, :donated_at, :datetime
  end
end
