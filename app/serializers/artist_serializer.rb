class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :genre, :songkick_id, :album_key, :embed_url

end
