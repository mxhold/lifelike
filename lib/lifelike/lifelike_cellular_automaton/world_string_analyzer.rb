module Lifelike
  class LifelikeCellularAutomaton
    class WorldStringAnalyzer
      def initialize(world_string, fallback_dead_char: ' ', fallback_alive_char: 'X')
        @world_string = world_string
        @fallback_dead_char = fallback_dead_char
        @fallback_alive_char = fallback_alive_char
      end

      def dead_char
        case valid_chars.size
        when 0
          raise InsufficientValidCharacterError.new(allowed_chars_by_aliveness)
        when 1
          deadlike_char || @fallback_dead_char
        else
          least_alive_valid_char
        end
      end

      def alive_char
        case valid_chars.size
        when 0
          raise InsufficientValidCharacterError.new(allowed_chars_by_aliveness)
        when 1
          lifelike_char || @fallback_alive_char
        else
          most_alive_valid_char
        end
      end

      private

      def deadlike_char
        valid_char if deadlike.include?(valid_char)
      end

      def lifelike_char
        valid_char if lifelike.include?(valid_char)
      end

      def valid_char
        valid_chars.first
      end

      def least_alive_valid_char
        valid_chars_by_aliveness.first
      end

      def most_alive_valid_char
        valid_chars_by_aliveness.last
      end

      def valid_chars_by_aliveness
        valid_chars.take(2).sort_by { |c| aliveness(c) }
      end

      def valid_chars
        @world_string.chars.uniq.select { |c| allowed_chars_by_aliveness.include?(c) }
      end

      # Roughly in order from most dead-like to most alive-like
      def allowed_chars_by_aliveness
        deadlike + lifelike
      end

      def deadlike
        [' ', '_', '.', ',', 'o', 'O', '0']
      end

      def lifelike
        ['1', 'x', '*', 'X', '#', '@']
      end

      def aliveness(char)
        allowed_chars_by_aliveness.index(char)
      end
    end
  end
end
