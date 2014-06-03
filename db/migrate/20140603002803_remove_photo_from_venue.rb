class RemovePhotoFromVenue < ActiveRecord::Migration
  def change
    remove_column :venues, :photo, :string
  end
end
