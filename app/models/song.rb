class Song < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :user

  validates :user_id, presence: true
  validates :spotify_id, presence: true
  validates :playlist_id, presence: true
  validates_uniqueness_of :user_id, :scope => [:spotify_id, :playlist_id]

  default_scope { where(:played => false) }
end
