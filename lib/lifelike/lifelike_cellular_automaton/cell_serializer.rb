module Lifelike
  class LifelikeCellularAutomaton
    class CellSerializer
      def initialize(alive_char:, dead_char:, rules:)
        @alive_char = alive_char
        @dead_char = dead_char
        @rules = rules
      end

      def cell_to_char(cell)
        if cell.alive?
          @alive_char
        else
          @dead_char
        end
      end

      def char_to_cell(char)
        Cell.new(alive?(char), @rules)
      end

      private

      def alive?(char)
        case char
        when @alive_char
          true
        when @dead_char
          false
        end
      end
    end
  end
end
