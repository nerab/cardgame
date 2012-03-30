module Uno
  class Card
    def initialize(name, color)
      @name, @color = name, color
    end
  
    def to_s
      "#{@name} #{@color}"
    end
  end
end
