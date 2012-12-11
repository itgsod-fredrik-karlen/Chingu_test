require 'chingu'

class Game < Chingu::Window

	def initialize
		super
		self.input = {esc: :exit}
		Background.create
		Player.create
		6.times {Cookie.create}
	end

	def update
		super
	Laser.each_bounding_circle_collision(Cookie) do |laser, target|
      		laser.destroy
      		target.destroy
    	end
    Giantlaser.each_bounding_circle_collision(Cookie) do |giantlaser, target|
      		target.destroy
    	end
	end
end


class Player <Chingu::GameObject
	has_traits :velocity, :timer
	#fake-konstruktor
	def setup
		@x = 400
		@y = 300
		
		@image = Gosu::Image["ship.png"]
		self.input = {holding_left: :left,
					holding_right: :right,
					holding_up: :up,
					holding_down: :down,
					space: :fire1,
					left_shift: :fire2}
		@speed = 10
		@angle = 0
		
	end

	def update
		self.velocity_x *= 0.95
		self.velocity_y *= 0.95
		
		@x %= 800
		@y %= 600		
	end

	def left
		@angle -= 10
	end

	def right
		@angle += 10
	end

	def up
		self.velocity_y += Gosu::offset_y(@angle, 1.0)
		self.velocity_x += Gosu::offset_x(@angle, 1.0)
	end

	def down
		self.velocity_y -= Gosu::offset_y(@angle, 1.0)
		self.velocity_x -= Gosu::offset_x(@angle, 1.0)
	end

	 def fire1
		Laser.create(x: self.x, y: self.y, angle: self.angle)
	 end

	def fire2
		Giantlaser.create(x: self.x, y: self.y, angle: self.angle)
	end
end

class Laser < Chingu::GameObject
	
	has_traits :velocity, :timer, :collision_detection, :bounding_circle
	def setup
		@image = Gosu::Image["laser.png"]
		self.velocity_y = Gosu::offset_y(@angle, 30)
		self.velocity_x = Gosu::offset_x(@angle, 30)
		after(1500) {self.destroy}

	end
end

class Giantlaser < Chingu::GameObject
	
	has_traits :velocity, :timer, :collision_detection, :bounding_circle
	def setup
		@image = Gosu::Image["giantlaser.png"]
		self.velocity_y = Gosu::offset_y(@angle, 20)
		self.velocity_x = Gosu::offset_x(@angle, 20)
		after(3000) {self.destroy}

	end

end

class Background <Chingu::GameObject
	def setup
		@image = Gosu::Image["planet.jpg"]
		@x = 400
		@y = 300
	end
end

class Cookie < Chingu::GameObject

	has_traits :velocity, :collision_detection, :bounding_circle

	def setup 
		@image = Gosu::Image["cookie.png"]
		@y = rand(600)
		@x = rand(800)
		@angle = rand(359)
		self.velocity_y = Gosu::offset_y(@angle, rand(1...10))
		self.velocity_x = Gosu::offset_x(@angle, rand(1...10))
	end

	def update
		@x %= 800
		@y %= 600
	end

end

Game.new.show