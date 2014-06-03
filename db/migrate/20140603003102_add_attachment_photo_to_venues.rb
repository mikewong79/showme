class AddAttachmentPhotoToVenues < ActiveRecord::Migration
  def self.up
    change_table :venues do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :venues, :photo
  end
end
