module Lifelike
  class LifelikeCellularAutomaton
    class CellSerializer
      def initialize(world_string, rules)
        @world_string = world_string
        @rules = rules
      end

      def cell_to_char(cell)
        if cell.alive?
          alive_char
        else
          dead_char
        end
      end

      def char_to_cell(char)
        Cell.new(alive?(char), @rules)
      end

      private

      def alive?(char)
        case char
        when alive_char
          true
        when dead_char
          false
        end
      end

      def alive_char
        two_most_frequent_chars_in_world_string.sort_by { |c| aliveness(c) }.last
      end

      def dead_char
        two_most_frequent_chars_in_world_string.sort_by { |c| aliveness(c) }.first
      end

      def two_most_frequent_chars_in_world_string
        @chars ||= valid_chars_in_world_string.reduce({}) do |frequencies, char|
          frequencies[char] = frequencies.fetch(char, 0) + 1
          frequencies
        end.sort_by { |c, f| -f }.take(2).to_h.keys
      end

      def valid_chars_in_world_string
        @world_string.chars.select { |c| valid_chars.include?(c) }
      end

      # In order from most dead-like to most alive-like
      def valid_chars
        [' ', '_', '.', 'o', '0', 'O', '1', '*', '#', 'x', 'X']
      end

      def aliveness(char)
        valid_chars.index(char)
      end
    end
  end
end