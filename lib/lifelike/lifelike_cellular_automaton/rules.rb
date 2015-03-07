module Lifelike
  class LifelikeCellularAutomaton
    class Rules
      def initialize(string)
        @rule_string = RuleString.new(string)
      end

      def survives?(alive_neighbor_count)
        @rule_string.alive_neighbors_to_survive.include?(alive_neighbor_count)
      end

      def born?(alive_neighbor_count)
        @rule_string.alive_neighbors_to_be_born.include?(alive_neighbor_count)
      end
    end

    class RuleString
      # See: http://www.conwaylife.com/wiki/Rule#Rules
      # Example: B3/S23
      def initialize(string)
        @string = string
      end

      def alive_neighbors_to_be_born
        numbers_after('B')
      end

      def alive_neighbors_to_survive
        numbers_after('S')
      end

      private

      def numbers_after(letter)
        @string[/#{letter}(\d*)/, 1].split('').map(&:to_i)
      end
    end
  end
end
