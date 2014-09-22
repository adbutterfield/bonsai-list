class RenameListingsTitleToHeadline < ActiveRecord::Migration
  def change
    rename_column :listings, :title, :headline
  end
end
