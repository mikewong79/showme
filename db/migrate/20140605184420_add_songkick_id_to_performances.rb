class AddSongkickIdToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :songkick_id, :integer
  end
end
