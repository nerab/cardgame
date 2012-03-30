module CardGame
  class BaseCard
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
    def trump?
      true
    end
  end
  
  class Card < BaseCard
    def initialize(rank, suit)
      super(rank)
      @suit = suit
    end

    def to_s
      "#{super} #{@suit}"
    end
  end
end
