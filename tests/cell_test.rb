require File.dirname(__FILE__) + '/../app/cell'
require 'test/unit'

class CellTest < Test::Unit::TestCase
	def test_cell_can_be_a_mine
		cell = Cell.new
		cell.value = 'mine'
		assert cell.is_a_mine?
	end
end