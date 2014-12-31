class UserPlaylist < ActiveRecord::Base
  belongs_to :user
  belongs_to :playlist

  validates :user_id, presence: true
  validates :playlist_id, presence: true

  validates_uniqueness_of :user_id, :scope => [:playlist_id]
end
