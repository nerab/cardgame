require 'helper'
require 'awesome_print'

class TestUno < Test::Unit::TestCase
  include CardGame
  
  def setup
    @deck = Uno.new
  end
  
  def test_size
    assert_equal(108, @deck.size)
  end
    
  def test_play
    players = []
    3.times{|i| players << Player.new(i)}
    stack = @deck.deal
    pile = []
    
    assert_equal(@deck.size, stack.size + players.inject(0){|sum, p| sum + p.size } + pile.size)
    
    7.times{
      players.each{|player|
        player << stack.pop
      }
    }
    
    # init the game
    begin
      pile.push(stack.pop)
    end while pile.first.trump? # do not allow trumps (jokers) as initial card
    
    assert_equal(@deck.size, stack.size + players.inject(0){|sum, p| sum + p.size } + pile.size)
    #dump_game(players, stack, pile)
    
    begin
      players.each{|player|
        played = player.play(pile.last)
        
        if (played)
          puts "player #{player} played #{played}"
          pile.push(played) # pile will ensure that everyone follows the rules
        else
          puts "player #{player} did not play, takes one from stack"
          player << stack.pop
        end
        # puts "player #{player} played #{pile.last} (#{player.size} left)"
        # raise "player #{player.object_id} wins." if player.empty?
      }
    #rescue RuleViolation
    #  puts "Not very nice, Mr. Smart!"
      # TODO How is the roll-back working? The player needs to take its card back.
    #rescue GameOver
    #  puts "Uno Uno!"
    ensure
      raise "TODO: Shuffle pile and turn it into stack" if stack.empty?
    end while !players.any?{|player| player.empty?}
  end
  
  def dump_game(players, stack, pile)
    players.each_with_index{|player, i|
      puts
      puts "* player ##{i} (#{player.size})"
      puts player
    }
    
    puts
    puts "* Stack (#{stack.size})"
    puts stack
    
    puts
    puts "* Pile (#{pile.size})"
    puts pile
  end
end
