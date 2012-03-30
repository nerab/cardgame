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
    def trump?
      true
    end
    
    def suit
      nil
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
