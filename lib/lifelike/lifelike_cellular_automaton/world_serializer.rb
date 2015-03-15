module Lifelike
  class LifelikeCellularAutomaton
    class WorldSerializer
      def initialize(cell_serializer)
        @cell_serializer = cell_serializer
      end

      def load(string)
        World.new(string_to_cell_grid(string))
      end

      def dump(world)
        cell_grid_to_string(world.cell_grid)
      end

      private

      def string_to_cell_grid(string)
        Grid.from_s(string) do |char|
          @cell_serializer.load(char)
        end
      end

      def cell_grid_to_string(cell_grid)
        cell_grid.to_s do |cell|
          @cell_serializer.dump(cell)
        end
      end
    end
  end
end
