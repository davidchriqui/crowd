class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :auth_token, uniqueness: true


  before_create :generate_authentication_token!
  before_create :defaut_password!

  has_many :products, dependent: :destroy
  has_many :songs, dependent: :destroy
  has_many :user_playlists, dependent: :destroy
  has_many :playlists, :through => :user_playlists

  def generate_authentication_token!
    begin
      self.auth_token = self.email
    end while self.class.exists?(auth_token: auth_token)
  end

  def defaut_password!
    self.password = "defaut"
    self.password_confirmation = "defaut"
  end

end
