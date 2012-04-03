require 'active_support/core_ext/string'

module CardGame
  class Card
    attr_reader :rank, :suit, :score
    
    def initialize(rank, score, suit = nil)
      @rank, @score, @suit = rank, score, suit
    end
    
    #
    # The following card only matches this one if both have either the same suit (color) or the same rank
    #
    def matches?(following_card)
      rank == following_card.rank || suit == following_card.suit
    end

    def trump?
      respond_to?(:suit=)
    end
    
    def to_s
      "#{suit.to_s.titleize} #{rank.to_s.titleize}"
    end
    
    def to_sym
      to_s.underscore.to_sym
    end
  end
  
  class Trump < Card
    # When playing a trump card, it's the player setting which suit it has, so that the next player has to follow it
    attr_accessor :suit
    
    def initialize(rank, score)
      super(rank, score)
    end
    
    def to_s
      "#{rank.to_s.titleize} requiring #{suit.to_s.titleize}"
    end
    
    def to_sym
      super.to_s.underscore.to_sym
    end
  end
end
