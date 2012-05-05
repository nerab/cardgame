require File.join(File.dirname(__FILE__), '..', 'helper')

class TestPlayOrder < Test::Unit::TestCase
  def test_empty
    assert_order('', [], 10)
  end

  def test_regular
    assert_order('ABCD', %w{A B C D})
  end

  def test_reverse
    result = ''
    play_order = CardGame::PlayOrder.new(%w{A B C D E F})
    
    1.upto(6).each{
      p = play_order.next!.to_s
      result << p
      play_order.reverse! if 'C' == p
    }
    assert_equal('ABCBAF', result)
  end

  def test_reverse_twice
    result = ''
    play_order = CardGame::PlayOrder.new(%w{A B C D E F G H I J K L})
    
    1.upto(12).each{
      p = play_order.next!.to_s
      result << p
      play_order.reverse! if 'C' == p
      play_order.reverse! if 'I' == p
    }
    
    assert_equal('ABCBALKJIJKL', result)
  end

  def test_skip
    result = ''
    play_order = CardGame::PlayOrder.new(%w{A B C D E F})
    
    1.upto(6).each{
      p = play_order.next!.to_s
      result << p
      play_order.skip! if 'C' == p
    }
    assert_equal('ABCEFA', result)
  end

  def test_next
    result = ''
    play_order = CardGame::PlayOrder.new(%w{A B C D E F})
    
    1.upto(20).each{
      result << play_order.next!.to_s
    }
    
    assert_equal('ABCDEFABCDEFABCDEFAB', result)
  end

  def test_start_reversed
    result = ''
    play_order = CardGame::PlayOrder.new(%w{A B C D E F})
    play_order.reverse!
    
    1.upto(20).each{
      result << play_order.next!.to_s
    }
    
    assert_equal('FEDCBAFEDCBAFEDCBAFE', result)
  end
  
  private
  
  #
  # Tests regular play order
  #
  def assert_order(expected, players, max = players.size)
    play_order = CardGame::PlayOrder.new(players)
    result = ''
    
    i = 0
    begin
      result << play_order.next!.to_s
      i += 1
    end while i < max
    
    assert_equal(expected, result)    
  end
end