class Pin < ActiveRecord::Base
  mount_uploader :image, PinUploader
  belongs_to :user
  belongs_to :board
  has_many :repins, dependent: :destroy
  acts_as_votable
  has_many :comments, dependent: :destroy
  
  validates_presence_of :image
  validates_presence_of :user_id
  validates_presence_of :board_id
  
  validate :picture_size
    
    def picture_size
      if image.size > 1.megabytes
        errors.add(:image, "Keep the image size below 1MB, please")
      end
    end
    
end
