module Uno
  class UnoDeck < Deck
    COLORS = %w{Blue Green Red Yellow}

    VALUES = {
      '0' => 1,
      '1' => 2,
      '2' => 2,
      '3' => 2,
      '4' => 2,
      '5' => 2,
      '6' => 2,
      '7' => 2,
      '8' => 2,
      '9' => 2,
      'Reverse' => 2,
      'Skip'    => 2,
      '+2 Draw' => 2
    }

    def initialize
      VALUES.each{|name, count|
        COLORS.each{|color|
          count.times{
            cards << Card.new(name, color)
          }
        }
      }

      4.times{
        cards << "+4 Draw"
        cards << "Wild"
      }
    end
  end
end