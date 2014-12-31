class SongSerializer < ActiveModel::Serializer
  attributes :id, :spotify_id, :user_id, :playlist_id
end
