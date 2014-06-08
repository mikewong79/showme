class AddFieldsToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :album_key, :string
    add_column :artists, :embed_url, :string
  end
end
