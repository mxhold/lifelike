module Lifelike
  class LifelikeCellularAutomaton
    class WorldStringAnalyzer
      def initialize(world_string, fallback_dead_char: ' ', fallback_alive_char: 'X')
        @world_string = world_string
        @fallback_dead_char = fallback_dead_char
        @fallback_alive_char = fallback_alive_char
      end

      def dead_char
        @dead_char ||= two_most_frequent_valid_chars_by_aliveness.fetch(0)
      end

      def alive_char
        @alive_char ||= two_most_frequent_valid_chars_by_aliveness.fetch(1)
      end

      private

      def two_most_frequent_valid_chars_by_aliveness
        case valid_chars_by_frequency.size
        when 0
          raise InsufficientValidCharacterError.new(valid_possible_chars_by_aliveness)
        when 1
          if deadlike.include?(valid_chars.first)
            [valid_chars.first, @fallback_alive_char]
          else
            [@fallback_dead_char, valid_chars.first]
          end
        else
          valid_chars_by_frequency.take(2).sort_by { |c| aliveness(c) }
        end
      end

      def valid_chars_by_frequency
        valid_char_frequencies.sort_by { |c, f| -f }.to_h.keys
      end

      def valid_char_frequencies
        valid_chars.reduce({}) do |frequencies, char|
          frequencies[char] = frequencies.fetch(char, 0) + 1
          frequencies
        end
      end

      def valid_chars
        @world_string.chars.select { |c| valid_possible_chars_by_aliveness.include?(c) }
      end

      # Roughly in order from most dead-like to most alive-like
      def valid_possible_chars_by_aliveness
        deadlike + lifelike
      end

      def deadlike
        [' ', '_', '.', ',', 'o', 'O', '0']
      end

      def lifelike
        ['1', 'x', '*', 'X', '#', '@']
      end

      def aliveness(char)
        valid_possible_chars_by_aliveness.index(char)
      end
    end
  end
end
