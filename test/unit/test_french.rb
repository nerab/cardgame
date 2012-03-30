require 'helper'

class TestFrench < Test::Unit::TestCase
  def setup
    @deck = CardGame::French.new
  end
  
  def test_size
    assert_equal(52, @deck.size)
  end
end
