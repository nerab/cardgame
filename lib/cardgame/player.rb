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
      "Player #{@name} (#{score})"
    end
    
    def score
      @hand.inject(0){|sum, c| sum += c.score}
    end
    
    #
    # Select one or more of our cards (according to our playing strategy)
    #
    # Note the the player has no further knowledge about the state of the game except the topmost card of the pile that is passed.
    # If a player wants to implement more advanced strategies (e.g. by observing and counting the cards already played),
    # we need to implement a notification mechanism that tells every player which card the current player played.
    #
    # TODO Need to obey if top_card is a trump, unless we can trump that one
    # TODO If the game system allows it, return two identical cards
    #
    def play(top_card)
      raise "There must be a card on the pile" if top_card.nil?
      
      candidates = @hand.select{|card| top_card.rank == card.rank || top_card.suit == card.suit  || card.trump?}
      LOGGER.debug "#{self} has #{@hand.size} in hand, #{candidates.size} are suitable on top of #{top_card}"
      
      selected = candidates.sort_by{rand}.pop
      
      if selected.nil?
        LOGGER.debug "#{self} decided NOT to play"
      else
        selected.suit = Deck::Uno.suits.sample if selected.trump? #  TODO Improve suit selection to take our current hand into account
        @hand.delete_if{|card| selected == card}
        LOGGER.debug "#{self} has #{@hand.size} cards remaining in hand"
        LOGGER.info "#{self} plays #{selected}"
      end
      
      # raise Uno.new(selected) if 1 == @hand.size
      raise Game::UnoUno.new(self, selected) if 0 == @hand.size
      
      selected
    end
    
    def_delegator :@hand, :size
    def_delegator :@hand, :<<
    def_delegator :@hand, :empty?
  end
end