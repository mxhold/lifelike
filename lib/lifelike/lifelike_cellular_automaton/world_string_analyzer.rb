module Lifelike
  class LifelikeCellularAutomaton
    class WorldStringAnalyzer
      def initialize(world_string)
        @world_string = world_string
      end

      def alive_char
        two_most_frequent_chars_in_world_string.sort_by { |c| aliveness(c) }.last
      end

      def dead_char
        two_most_frequent_chars_in_world_string.sort_by { |c| aliveness(c) }.first
      end

      private

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
