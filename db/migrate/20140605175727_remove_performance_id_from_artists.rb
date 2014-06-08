class RemovePerformanceIdFromArtists < ActiveRecord::Migration
  def change
    remove_column :artists, :performance_id
  end
end
