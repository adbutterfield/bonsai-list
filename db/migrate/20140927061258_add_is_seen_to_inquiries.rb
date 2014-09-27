class AddIsSeenToInquiries < ActiveRecord::Migration
  def change
    add_column :inquiries, :is_seen, :boolean, default: false
  end
end
