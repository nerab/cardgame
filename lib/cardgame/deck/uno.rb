module CardGame
  module Deck
    class Uno < Base
      class << self
        NUMBERED_CARDS = {
          :null    => {:name => '0',           :score => 0,  :count => 1},
          :one     => {:name => '1',           :score => 1,  :count => 2},
          :two     => {:name => '2',           :score => 2,  :count => 2},
          :three   => {:name => '3',           :score => 3,  :count => 2},
          :four    => {:name => '4',           :score => 4,  :count => 2},
          :five    => {:name => '5',           :score => 5,  :count => 2},
          :six     => {:name => '6',           :score => 6,  :count => 2},
          :seven   => {:name => '7',           :score => 7,  :count => 2},
          :eight   => {:name => '8',           :score => 8,  :count => 2},
          :nine    => {:name => '9',           :score => 9,  :count => 2},
          :reverse => {:name => 'Reverse',     :score => 20, :count => 2},
          :skip    => {:name => 'Skip',        :score => 20, :count => 2},
          :draw_2  => {:name => 'Draw 2',      :score => 20, :count => 2},
        }

        TRUMP_CARDS = {
          :wild_draw_4  => {:name => 'Wild Draw 4', :score => 50, :count => 4},
          :wild         => {:name => 'Wild',        :score => 50, :count => 4},
        }
      
        def score(rank, suite = nil)
          result = NUMBERED_CARDS.merge(TRUMP_CARDS)[rank] # Uno calculates score solely based on the card's rank
          raise "Unknown card #{rank}" unless result
          result[:score]
        end
    
        def ranks
          multiplied(NUMBERED_CARDS)
        end
    
        def trumps
          multiplied(TRUMP_CARDS)
        end
    
        def suits
          [:blue, :green, :red, :yellow]
        end
      
        private
        def multiplied(definition)
          ranks = []
          definition.each{|id, properties|
            ranks.concat([id] * properties[:count])
          }
          ranks
        end
      end
    end
  end
end