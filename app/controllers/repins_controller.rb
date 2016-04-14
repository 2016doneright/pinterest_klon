class RepinsController < ApplicationController
    
    def show
       
    end
    
    def create
        
        @pin = Pin.find(params[:pin_id])
        @board = Board.find(params[:board_id])
        @repin = Repin.create(pin_id: @pin.id, board_id: @board.id)
        duplicate = @pin.dup
        duplicate.id = Faker::Number.number(9)
        duplicate.user_id = current_user.id
        duplicate.board_id = @board.id # that would be @board
        duplicate.image = @pin.image
        duplicate.save
        
        @repin.update(user_id: current_user.id, dup_id: duplicate.id)
 
    end
end
