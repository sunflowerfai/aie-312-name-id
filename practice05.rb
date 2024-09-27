
class User
    attr_accessor :name, :email, :password
  
    def initialize(name, email, password)
      @name = name
      @email = email
      @password = password
      @rooms = []  
    end
  
    def enter_room(room)
      @rooms << room unless @rooms.include?(room)
      room.users << self unless room.users.include?(self)
    end
  
    def send_message(room, content)
      if @rooms.include?(room)
        message = Message.new(self, room, content)
        room.broadcast(message)
      else
        puts "You must enter the room before you can send a message."
      end
    end
  
    def acknowledge_message(room, message)
      puts "#{name} received: '#{message.content}' from #{message.user.name} in room '#{room.name}'."
    end
  end
  
  class Room
    attr_accessor :name, :description, :users
  
    def initialize(name, description)
      @name = name
      @description = description
      @users = []  
    end
  
    def broadcast(message)
      users.each do |user|
        user.acknowledge_message(self, message)
      end
    end
  end
  
  class Message
    attr_accessor :user, :room, :content
  
    def initialize(user, room, content)
      @user = user
      @room = room
      @content = content
    end
  end
  
  user1 = User.new("kannika", "kannika@gmail.com", "password123")
  user2 = User.new("prangthong", "prangthong@example.com", "password456")
  
  room = Room.new("Chat Room", "ห้องนอน")
  
  user1.enter_room(room)
  user2.enter_room(room)
  
  user1.send_message(room, "Hello!")
  