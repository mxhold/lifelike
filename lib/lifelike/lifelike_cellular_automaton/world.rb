module Lifelike
  class LifelikeCellularAutomaton
    class World
      attr_reader :cell_grid
      def initialize(cell_grid)
        @cell_grid = cell_grid
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
          end
        )
      end
    end
  end
end
