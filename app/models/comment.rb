class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :pin
  validates_presence_of :content
end
