require File.dirname(__FILE__) + '/../app/cell'
require File.dirname(__FILE__) + '/../app/minefield'

class Game
	attr_reader :num_of_rows, :num_of_cols, :total_mine_count, :minefield

	def initialize options={}
		@num_of_rows = options[:num_of_rows] || 9
		@num_of_cols = options[:num_of_cols] || 9
		@total_mine_count  = options[:total_mine_count] || 10
		@total_cell_count = @num_of_cols * @num_of_rows
		@minefield = Minefield.new

		init_field
		place_mines
		add_counts
	end

	def start
		while !has_ended?
		  display_board
		  command = gets
		  action, row, col = command.chomp.split ','
		  row=row.to_i
		  col=col.to_i
		  if row < @num_of_rows && col < @num_of_cols &&
		  	row >= 0 && col >= 0
			  @minefield.send action.to_sym, row, col
			else
				p "you must choose a valid value"
			end
		end

		if lose_condition
			display_board
			p "You lose"
		elsif win_condition
			display_board
			p "congrats"
		end
	end

	def has_ended?
		lose_condition || win_condition 
	end

	def lose_condition
		@minefield.any_revealed_mines?
	end

	def win_condition
		@minefield.cleared?
	end

	def init_field
		cells = []
		@total_cell_count.times do
			cells << Cell.new
		end
		cells.each_slice(9) do |row|
			@minefield << row
		end
	end

	def place_mines
		while @minefield.current_mine_count < @total_mine_count
			@minefield[rand(9)][rand(9)].place_mine
		end
	end

	def add_counts
		@num_of_cols.times do |col|
			@num_of_rows.times do |row|
				@minefield[row][col].value = @minefield.nearby_mine_count(row, col) unless @minefield[row][col].is_a_mine?
			end
		end
	end

	def display_board
		@minefield.display
	end
end
