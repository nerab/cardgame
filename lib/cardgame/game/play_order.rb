module CardGame
  #
  # Maintains the order in which players play. Supports reverse and skip while iterating.
  #
  class PlayOrder
    def initialize(players)
      @players = players
      
      # Whether we count up or down. Defaults to up.
      @upwards = true
      
      # Index of the next player
      @next = 0
    end
    
    #
    # Returns the next player within the current play order
    #
    def next!
      return nil if @players.empty?
      
      begin
        @players[@next % @players.size]
      ensure
        skip! # shift the next pointer
      end
    end
    
    #
    # Reverses the play order
    #
    def reverse!
      @upwards = !@upwards
      skip!(2)
    end
    
    #
    # Skips count players in the current play order
    #
    def skip!(count = 1)
      @next += count * (@upwards ? 1 : -1)
    end
  end
end
