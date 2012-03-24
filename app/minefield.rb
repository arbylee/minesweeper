class Minefield < Array

	def height
		self.length
	end

	def width
		self[0].length
	end

	def current_mine_count
		self.flatten.count {|cell| cell.is_a_mine?}
	end

	def nearby_mine_count row, col
    width_range = [col - 1, 0].max..[col + 1, width - 1].min
    height_range = [row - 1, 0].max..[row + 1, height - 1].min

    mine_count = 0
    width_range.each do |c|
    	height_range.each do |r|
    		if r != row || c != col
	    		mine_count +=1 if self[r][c].is_a_mine?
	    	end
	    end
	  end
	  mine_count
	end

	def reveal_cell row, col
		self[row][col].status = Cell::Status::REVEALED
	end

	def flag_cell row, col
		self[row][col].status = Cell::Status::FLAGGED
	end

	def display
		visible_board = []
		self.each do |row|
			a_row = []
			row.each do |cell|
				a_row << cell.to_display
			end
			visible_board << a_row
		end
		visible_board.each do |row|
			p row
		end
	end

	def cleared?
		mines, safe_cells = self.flatten.partition {|cell| cell.is_a_mine?}
		mines.all? {|mine| mine.is_flagged?} && safe_cells.all? {|cell| cell.is_revealed?}
	end

	def any_revealed_mines?
		self.flatten.any? {|cell| cell.is_a_mine? && cell.is_revealed?}
	end
end