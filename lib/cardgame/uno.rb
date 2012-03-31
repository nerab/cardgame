module CardGame
  class Uno < Deck
    class << self
      def ranks
        ['0'].concat(%w{1 2 3 4 5 6 7 8 9 Reverse Skip} * 2).concat(['Draw 2'] * 2)
      end
    
      def trumps
        ["Wild Draw 4"] * 4 + ["Wild"] * 4
      end
    
      def suits
        %w{Blue Green Red Yellow}
      end
    end
  end
end