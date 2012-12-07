require 'chingu'

class Game < Chingu::Window

	def initialize
		super
		self.input = {esc: :exit}
		Player.create
	end

end


class Player <Chingu::GameObject

	#fake-konstruktor
	def setup
		@x = 400
		@y = 300
		@image = Gosu::Image["ship.png"]
	end

end

Game.new.show