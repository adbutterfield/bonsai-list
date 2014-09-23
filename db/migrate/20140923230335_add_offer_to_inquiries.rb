class AddOfferToInquiries < ActiveRecord::Migration
  def change
    add_column :inquiries, :offer, :decimal, precision: 10, scale: 2
  end
end
