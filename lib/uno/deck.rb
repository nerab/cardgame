require 'forwardable'

module Uno
  class Deck
    extend Forwardable
    def_delegator :@cards, :push
    def_delegator :@cards, :<<
    def_delegator :@cards, :pop
    def_delegator :@cards, :size
    
    def initialize
      @cards = []
    end
    
    protected
    attr_reader :cards
  end
end