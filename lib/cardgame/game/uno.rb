module CardGame
  module Game
    class RuleViolation < StandardError; end

    class UnoUno < StandardError
      attr_reader :player, :card
  
      def initialize(player, card)
        @player, @card = player, card
      end
    end
    
    class DrawPile
      extend Forwardable
      def_delegator :@pile, :pop, :draw
      def_delegator :@pile, :empty?
      
      def initialize
        @pile = Deck::Uno.new.deal
      end
      
      def replenish(discard_pile)
        @pile.concat(discard_pile)
        discard_pile.clear
        discard_pile.push(@pile.pop) # the last card stays on the discard pile
        @pile.sort_by!{rand}
      end
    end

    class DiscardPile
      extend Forwardable
      def_delegator :@pile, :push
      def_delegator :@pile, :last, :top
      
      def initialize
        @pile = []
      end
    end
    
    class Uno
      attr_reader :winner, :rounds
      
      def initialize(players)
        @draw_pile = DrawPile.new
        @discard_pile = DiscardPile.new
        
        # deal out cards to the players
        7.times{
          players.each{|player|
            player << @draw_pile.draw
          }
        }
        
        # init the discard pile by drawing the first card from the draw pile
        begin
          @discard_pile.push(@draw_pile.draw)
          LOGGER.debug "Attempting to start with #{@discard_pile.top} (#{@discard_pile.top.score})"
        end while 9 < @discard_pile.top.score # do not allow trumps (jokers) or word cards (score > 9) as initial card

        LOGGER.info "Finally starting the game with #{@discard_pile.top}"
        @rounds = 0

        # main game loop - ask each player to play
        begin
          loop do
            @rounds += 1
            players.each{|player|
              begin
                played = player.play(@discard_pile.top)
    
                if played && matches_rules(played)
                  @discard_pile.push(played)
                else
                  @draw_pile.replenish(@discard_pile) if @draw_pile.empty?
                  player << @draw_pile.draw
                end
              rescue RuleViolation => v
                LOGGER.error v.message
                player << played # Push the offending card back to the player
                retry
              end
            }
          end
        rescue CardGame::Game::UnoUno => u
          @winner = u.player
        end
        LOGGER.info "#{@winner} wins after #{@rounds} rounds."
      end
      
      private
      
      #
      # Ensure that everyone follows the rules
      # e.g. from https://en.wikipedia.org/wiki/Uno_(card_game)
      #
      # TODO Delegate to rules engine, dynamically selectable by players (if every player agrees on the same ruleset)
      #
      def matches_rules(played)
        true
      end
    end
  end
end