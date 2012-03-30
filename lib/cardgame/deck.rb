require 'forwardable'

module CardGame
  class Deck
    extend Forwardable
    
    def initialize
      @cards = []
      
      ranks.each{|name|
        suits.each{|color|
          push Card.new(name, color)
        }
      }
      
      trumps.each{|j| push Trump.new(j)}
    end
    
    #
    # Deal out a shuffled deck
    #
    def deal
      @cards.sort_by{rand}
    end
    
    def ranks
      []
    end
    
    def trumps
      []
    end
    
    def suits
      []
    end
    
    def_delegator :@cards, :size
    
    private
    def_delegator :@cards, :push
  end
end