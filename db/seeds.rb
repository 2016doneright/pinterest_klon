# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Pin.destroy_all
Board.destroy_all

25.times do |i|
    User.create do |user|
        user.email = Faker::Internet.email
        user.password = "agasdgasdgasd"
        user.avatar = open("db/uifaces/#{i}.jpg")
        user.cover = open("db/three_to_one/#{i}.jpg")
        user.real_name = Faker::Name.first_name + " " + Faker::Name.last_name
        user.profile_name = (user.real_name).gsub(/\s/,"").downcase
        puts "#{user.real_name} created"
    end
end

for current in 1..250
    Board.create do |board|
      board.title = Faker::Commerce.department.capitalize
      board.description = Faker::Lorem.sentence
      board.user_id = User.find(User.pluck(:id).sample).id
    end
end

3.times do |i|
    for current in 1..900
       Pin.create do |pin|
          pin.title = Faker::Company.bs.capitalize
          pin.image = open("db/mix/#{current}.jpg")
          pin.user_id = User.find(User.pluck(:id).sample).id
          pin.board_id = Board.find(Board.pluck(:id).sample).id
       end
    end
end

hashtags = %w(fashion friends smile like4like instamood family amazing nofilter style follow4follow sun tflers beach lol hair  iphoneonly cool girls webstagram funny iphonesia tweegram black instacool makeup igdaily instagramhub awesome instafollow  bored nice eyes all_shots throwback look)

12500.times do |i|
    Comment.create do |comment|
        comment.content = Faker::Hacker.say_something_smart
        comment.user_id = User.all.sample.id
        comment.pin_id = Pin.find(Pin.ids.sample).id
        
    end
end

puts "====================="
puts "about to do following"

1500.times do(User.all.sample.follow(User.all.sample))end

puts "====================="
puts "about to do liking"

12500.times do (User.all.sample.likes(Pin.find(Pin.ids.sample)))end

puts "about to do following boards"

500.times do (User.all.sample.follow(Board.all.sample))end


