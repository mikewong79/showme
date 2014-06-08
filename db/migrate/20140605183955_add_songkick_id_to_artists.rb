class AddSongkickIdToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :songkick_id, :integer
  end
end
