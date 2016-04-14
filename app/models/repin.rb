class Repin < ActiveRecord::Base
  belongs_to :user
  belongs_to :board
  belongs_to :pin
end
