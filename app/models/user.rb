class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover, CoverUploader
  has_many :pins, dependent: :destroy
  has_many :boards, dependent: :destroy
  has_many :repins, dependent: :destroy
  has_many :comments, dependent: :destroy
  acts_as_follower
  acts_as_followable
  acts_as_voter
  
end
