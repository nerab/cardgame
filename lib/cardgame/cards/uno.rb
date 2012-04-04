module CardGame
  module Cards
    module Uno
      class Reverse < Card
        def initialize(suit)
          super("Reverse", 20, suit)
        end
        
        def fire!(game)
          super{game.reverse_playorder!}
        end
      end

      class Skip < Card
        def initialize(suit)
          super("Skip", 20, suit)
        end
        
        def fire!(game)
          super{game.skip_next!}
        end
      end

      class Draw2 < Card
        def initialize(suit)
          super("Draw 2", 20, suit)
        end
        
        def fire!(game)
          super{game.draw!(2)}
        end
      end

      class Wild < Trump
        def initialize
          super("Wild", 50)
        end
      end

      class WildDraw4 < Trump
        def initialize
          super("Wild Draw 4", 50)
        end
        
        def fire!(game)
          super{game.draw!(4)}
        end
      end
    end
  end
end