class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.references :user, index: true
      t.references :listing, index: true

      t.timestamps
    end
  end
end
