module Lifelike
  class LifelikeCellularAutomaton
    class World
      def initialize(grid, cell_serializer:)
        @grid = grid
        @cell_serializer = cell_serializer
      end

      def self.from_s(string, rules)
        cell_serializer = CellSerializer.new(string, rules)
        new(
          Grid.from_s(string) do |char|
            cell_serializer.char_to_cell(char)
          end,
          cell_serializer: cell_serializer
        )
      end

      def to_s
        @grid.to_s do |cell|
          @cell_serializer.cell_to_char(cell)
        end
      end

      def tick(generations)
        (1..generations).reduce(self) do |world, _|
          world.tick_once
        end
      end

      def tick_once
        self.class.new(
          @grid.map_with_neighbors do |cell, neighbors|
            cell.tick(neighbors)
          end,
          cell_serializer: @cell_serializer
        )
      end
    end
  end
end
