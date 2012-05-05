require File.join(File.dirname(__FILE__), '..', 'helper')

class TestFrench < CardGameTest::TestCase
#  include CardGameTest::DeckTests
  
  def setup
    @deck = CardGame::Deck::French.new
  end
  
  def test_size
    assert_equal(52, @deck.size)
  end
end
