require 'timeout'

module CardGame
  module Game
    class RuleViolation < StandardError; end

    class MustNotPlayDrawnCard < RuleViolation
      def initialize(player, played_card)
        super("#{player} played the card #{played_card} that he had just taken from the draw pile")
      end
    end

    class PlayTimeout < RuleViolation
      def initialize(player, timeout_seconds)
        super("#{player} did not play within #{timeout_seconds} seconds")
      end
    end

    class TooManyRuleViolations < RuleViolation
      def initialize(player, max_violations_count)
        super("#{player} exceeded the limit of #{max_violations_count} rule violations")
      end
    end

    class Uno
      attr_reader :winner, :rounds

      def initialize(players)
        @players = players

        @discard_pile = DiscardPile.new
        @draw_pile = DrawPile.new(Deck::Uno.new, @discard_pile)

        # Deal out cards to the players
        7.times{
          players.each{|player|
            player.draw(@draw_pile)
          }
        }
      end

      def play!(player_timeout = 5, max_allowed_violations = 3)
        # Init the discard pile by drawing the first card from the draw pile
        begin
          @discard_pile.push(@draw_pile.draw)
          LOGGER.debug "Attempting to start with #{@discard_pile.top} (#{@discard_pile.top.score})"
        end while 9 < @discard_pile.top.score # Do not allow trumps (jokers) or word cards (score > 9) as initial card
        # TODO Some rules say that only Wild or Wild Draw 4 are not allowed for starters

        LOGGER.info "Finally starting the game with #{@discard_pile.top}"
        @rounds = 0
        @winner = nil

        # Main game loop - ask each player to play
        begin
          loop do
            @rounds += 1
            @players.each{|player|
              @player = player

              begin
                begin
                  top = @discard_pile.top

                  # Take the action the topmost card requires
                  may_play = top.fire!(self)

                  if !may_play
                    LOGGER.info "Skipping #{@player} due to #{top}"
                    next
                  end

                  # Ask the player to play (within timeout)
                  played = Timeout::timeout(player_timeout){@player.play(top)}

                  if !played
                    draw!(1) # Player decided to pass (by returning nil)
                  else
                    assert_rules(played)
                    @discard_pile.push(played) # Put the played card on top of the discard pile
                    @winner = @player if 0 == @player.hand.size
                  end
                rescue Timeout::Error => e
                  LOGGER.warn(e.message)
                  raise PlayTimeout.new(@player, player_timeout) # timeout is a rule violation
                end
              rescue RuleViolation => v
                LOGGER.warn(v.message)
                @player.rule_violation(v) # let the player know
                @player.hand << played # Push the offending card back to the player

                if max_allowed_violations >= @player.violations.size
                  retry
                else
                  raise TooManyRuleViolations.new(@player, max_allowed_violations)
                end
              end
            }
            break if @winner
          end
        rescue TooManyRuleViolations => v
          LOGGER.error(v.message) # TODO Let player know
          @players.delete(@player) # Game goes on without player
          @discard_pile.recycle(@player.hand) # Put the player's cards on the floor of the discard pile
        end
        LOGGER.info "#{@winner} wins after #{@rounds} rounds."
      end

      def reverse_playorder!
        LOGGER.info "Reversing player order"
        @players.reverse!
        true
      end

      def skip_next!
        LOGGER.info "Skipping next player #{@player}"
        false
      end

      #
      # Let's the active player draw +count+ card(s)
      #
      def draw!(count)
        @player.draw(@draw_pile, count)
        true
      end

      private

      #
      # Ensure that everyone follows the rules
      # e.g. from https://en.wikipedia.org/wiki/Uno_(card_game)
      #
      # TODO Delegate to rules engine, dynamically selectable by players (if every player agrees on the same ruleset)
      #
      def assert_rules(played)
        top = @discard_pile.top
        raise MustNotPlayDrawnCard.new(@player, played) if played == top
      end
    end
  end
end
