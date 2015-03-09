module Lifelike
  class LifelikeCellularAutomaton
    class CellSerializer
      def initialize(world_string)
        c1, c2 = world_string.chars.select { |c| char_precedence.include?(c) }.reduce({}) do |frequencies, char|
          frequencies[char] = frequencies.fetch(char, 0) + 1
          frequencies
        end.sort_by { |c, f| -f }.take(2).to_h.keys
        if char_precedence.index(c1) > char_precedence.index(c2)
          alive = c1
          dead = c2
        else
          alive = c2
          dead = c1
        end
        @char_to_bool = { alive => true, dead => false }
      end

      def bool_to_char(bool)
        @bool_to_char ||= @char_to_bool.invert
        @bool_to_char.fetch(bool)
      end

      def char_to_bool(char)
        @char_to_bool.fetch(char)
      end

      private

      def char_precedence
        # From dead to alive
        [' ', '_', '.', 'o', '0', 'O', '1', '*', '#', 'x', 'X']
      end
    end
  end
end
