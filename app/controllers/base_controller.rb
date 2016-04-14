class BaseController < ApplicationController
  
  require 'will_paginate/array'
  
  def feed
    @following = current_user.following_users.ids
    @pins = Pin.where('user_id in (?)', @following).shuffle.paginate(:page => params[:page], :per_page => 12)
  end
end
