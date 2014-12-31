class PlaylistSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :songs
end
