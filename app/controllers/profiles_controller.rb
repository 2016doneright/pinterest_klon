class ProfilesController < ApplicationController
    require 'will_paginate/array'
    
    def show
        @user = User.find_by_profile_name(params[:profile_name])
        @pins = @user.find_liked_items.reverse.last(12)
    end
    
    def guest
        random_user = User.find(rand(1..25))
        sign_in(:user, random_user)
        redirect_to root_path
    end
    
    def follow
        @user = User.find_by_profile_name(params[:profile_name])
        current_user.follow(@user)
    end
    
    def stop_following
        @user = User.find_by_profile_name(params[:profile_name])
        current_user.stop_following(@user)
    end
    
    def following
        @user = User.find_by_profile_name(params[:profile_name])
        @users = @user.following_users.order('created_at desc').limit(10)
    end
  
    def followers
        @user = User.find_by_profile_name(params[:profile_name])
        @users = @user.users_followers.order('created_at desc').limit(10)
    end
  
    def likes
        @user = User.find_by_profile_name(params[:profile_name])
        @likes = @user.find_liked_items.reverse.paginate(:page => params[:page], :per_page => 15)
    end
    
    def boards
        @user = User.find_by_profile_name(params[:profile_name])
        @boards = @user.boards.order('created_at desc').limit(10)
    end
    
    def following_boards
       @user = User.find_by_profile_name(params[:profile_name]) 
       @following_boards = @user.following_boards.order('created_at desc').limit(10)
    end
    
    def pins
       @user = User.find_by_profile_name(params[:profile_name]) 
       @pins = @user.pins.reverse.paginate(:page => params[:page], :per_page => 15)
    end
end
