class AddSongkickFieldsToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :songkick_id, :integer
    add_column :venues, :lat, :float
    add_column :venues, :lng, :float
  end
end
