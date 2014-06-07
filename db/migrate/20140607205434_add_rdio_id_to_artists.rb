class AddRdioIdToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :rdio_id, :integer
  end
end
