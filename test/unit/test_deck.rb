require 'helper'

class TestUnoDeck < Test::Unit::TestCase
  def setup
    @deck = Uno::Deck.new
  end
  
  def test_size
    assert_equal(108, @deck.size)
  end
end

# puts cards.size
#deck = cards.sort_by{rand}
#
#7.times{
#  puts "Drawn: #{deck.pop}"
#  puts "#{deck.size} left"
#}
