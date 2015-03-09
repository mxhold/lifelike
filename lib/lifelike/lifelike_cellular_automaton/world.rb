module Lifelike
  class LifelikeCellularAutomaton
    class World
      def initialize(cell_grid, cell_serializer:)
        @cell_grid = cell_grid
        @cell_serializer = cell_serializer
      end

      def cell_grid
        @cell_grid
      end

      def tick(generations)
        (1..generations).reduce(self) do |world, _|
          world.tick_once
        end
      end

      def tick_once
        self.class.new(
          @cell_grid.map_with_neighbors do |cell, neighbors|
            cell.tick(neighbors)
          end,
          cell_serializer: @cell_serializer
        )
      end
    end
  end
end
