class CreateJoinTablePerformanceArtist < ActiveRecord::Migration
  def change
    create_join_table :performances, :artists do |t|
      # t.index [:performance_id, :artist_id]
      # t.index [:artist_id, :performance_id]
    end
  end
end
