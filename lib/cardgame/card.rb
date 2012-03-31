module CardGame
  class BaseCard
    attr_reader :rank
    
    def initialize(rank)
      @rank = rank
    end
  
    def to_s
      @rank
    end
    
    def trump?
      false
    end
  end
  
  class Trump < BaseCard
    # When playing a trump card, the player can set which suit it has so that the next player has to follow it
    attr_accessor :suit
    
    def trump?
      true
    end

    def to_s
      "#{super} requiring #{@suit}"
    end
  end
  
  class Card < BaseCard
    attr_reader :suit
    
    def initialize(rank, suit)
      super(rank)
      @suit = suit
    end

    def to_s
      "#{@suit} #{super}"
    end
  end
end
