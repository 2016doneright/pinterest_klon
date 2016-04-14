class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy, :like, :unlike]
  require 'will_paginate/array'
  
  # GET /pins
  # GET /pins.json
  def index
    @pins = Pin.all
  end

  # GET /pins/1
  # GET /pins/1.json
  def show
    @find = @pin.board.pins.ids - [@pin.id]
    @siblings = Pin.where('id in (?)', @find).paginate(:page => params[:page], :per_page => 12)
    @comments = @pin.comments.limit(6)
  end

  # GET /pins/new
  def new
    @pin = Pin.new
  end

  # GET /pins/1/edit
  def edit
  end
  
  def like
    current_user.likes(@pin)
  end
  
  def unlike
    current_user.unlike(@pin)
  end
  # POST /pins
  # POST /pins.json
  def create
    @board = Board.find(params[:board_id])
    @pin = current_user.pins.new(pin_params)
    @pin.update(board_id: @board.id)
    respond_to :js
  end

  # PATCH/PUT /pins/1
  # PATCH/PUT /pins/1.json
  def update
    respond_to do |format|
      if @pin.update(pin_params)
        format.html { redirect_to @pin, notice: 'Pin was successfully updated.' }
        format.json { render :show, status: :ok, location: @pin }
      else
        redirect_to :back
      end
    end
  end

  # DELETE /pins/1
  # DELETE /pins/1.json
  def destroy
    @pin.destroy
    respond_to do |format|
      format.html { redirect_to pins_url, notice: 'Pin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:title, :description, :image, :user_id, :board_id)
    end
end
