class Board < ActiveRecord::Base
  belongs_to :user
  has_many :pins, dependent: :destroy
  has_many :repins, dependent: :destroy
  acts_as_followable
  
  validates_presence_of :title
  validates_presence_of :description
end
