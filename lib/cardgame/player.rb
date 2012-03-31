require 'forwardable'

module CardGame
  class Player
    extend Forwardable
    attr_reader :name
    
    def initialize(name)
      @name = name
      @hand = []
    end
    
    def to_s
      "Player #{@name}"
    end
    
    #
    # Select one or more of our cards (according to our playing strategy)
    #
    # Note the the player has no further knowledge about the state of the game except the topmost card of the pile that is passed.
    # If a player wants to implement more advanced strategies (e.g. by observing and counting the cards already played),
    # we need to implement a notification mechanism that tells every player which card the current player played.
    #
    # TODO Need to obey if top_card is a trump, unless we can trump that
    # TODO If the game system allows it, return two same cards
    #
    def play(top_card)
      puts "#{self} has #{@hand.size} in hand and sees the top card #{top_card}"
      
      candidates = @hand.select{|card| top_card.rank == card.rank || top_card.suit == card.suit  || card.trump?}
      puts "#{self} has #{candidates.size} candidates to choose from."
      
      selected = candidates.sort_by{rand}.pop
      selected.suit = Uno.suits.select{rand} if selected.trump? #  TODO Improve suit selection to take our current hand into account
      
      if selected.nil?
        puts "#{self} decided NOT to play"
      else
        puts "#{self} decided to play #{selected}"
        @hand.delete_if{|card| selected == card}
        puts "#{self} has #{@hand.size} left in hand."
      end
      
      raise Uno.new(selected) if 1 == @hand.size
      raise UnoUno.new(selected) if 0 == @hand.size
      
      selected
    end
    
    def_delegator :@hand, :size
    def_delegator :@hand, :<<
    def_delegator :@hand, :empty?
  end
end