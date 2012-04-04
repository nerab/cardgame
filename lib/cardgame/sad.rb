module CardGame
  class SafeArmFireDevice
    def initialize
      @armed = true
    end
    
    def fire!(game)
      if !armed?
        return true
      end
  
      result = block_given? ? yield : true
      
      # the card is "eaten" - disarm it so that it will not be executed twice before the discard pile is replenished again
      disarm!
      
      return result
    end

    def arm!
      @armed = true
    end

    def disarm!
      @armed = false
    end

    def armed?
      @armed
    end
  end
end