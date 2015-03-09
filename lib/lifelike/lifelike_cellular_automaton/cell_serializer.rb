module Lifelike
  class LifelikeCellularAutomaton
    class CellSerializer
      def initialize(world_string, rules)
        world_string_analyzer = WorldStringAnalyzer.new(world_string)
        @alive_char = world_string_analyzer.alive_char
        @dead_char = world_string_analyzer.dead_char
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
