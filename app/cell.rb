class Cell
	attr_accessor :value, :status
	
	MINE = 'mine'

	module Status
		REVEALED = 'revealed'
		FLAGGED = 'flagged'
	end

	def is_a_mine?
		self.value == MINE
	end

	def place_mine
		self.value = MINE
	end

	def is_revealed?
		self.status == Status::REVEALED
	end

	def is_flagged?
		self.status == Status::FLAGGED
	end

	def to_display
		return self.value if is_revealed?
		return "<|" if is_flagged?
		"?"
	end
end