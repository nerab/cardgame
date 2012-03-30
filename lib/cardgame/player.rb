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
      "Player #{@name} (#{size} cards)"
    end
    
    #
    # Select one or more of our cards (according to our playing strategy)
    #
    # Note the the player has no further knowledge about the state of the game except the topmost card of the pile that is passed.
    # If a player wants to implement more advanced strategies (e.g. by observing and counting the cards already played),
    # we need to implement a notification mechanism that tells every player which card the current player played.
    #
    # TODO Need to obey if top_card is a trump, unless we can trump that
    #
    def play(top_card)
      # Dead-simple strategy: Just take the first match.
      idx = @hand.find_index{|card| top_card.rank == card.rank || top_card.suit == card.suit  || card.trump?} 
      @hand.delete_at(idx) if idx
      # TODO An alternative strategy could be delete_if with the block above, pop one from the result and stuff back the rest
    end
    
    def_delegator :@hand, :size
    def_delegator :@hand, :<<
    def_delegator :@hand, :empty?
  end
end