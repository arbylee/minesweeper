require File.dirname(__FILE__) + '/../app/game'
require 'test/unit'

class GameTest < Test::Unit::TestCase
	def test_can_create_a_board
		game = Game.new
		assert_equal 9, game.minefield.length
	end

	def test_minefield_has_the_correct_number_of_mines
		game = Game.new
		mines = game.minefield.flatten.select do |cell|
			cell.is_a_mine?
		end
		assert_equal 10, mines.length
	end

	def test_display
		game = Game.new
		game.minefield.reveal_cell 2,2
		game.display_board
	end
end