module Lifelike
  class LifelikeCellularAutomaton
    class WorldSerializer
      def initialize(string, rules)
        @cell_serializer = CellSerializer.new(string, rules)
      end

      def string_to_world(string)
        World.new(string_to_cell_grid(string), cell_serializer: @cell_serializer)
      end

      def world_to_string(world)
        cell_grid_to_string(world.cell_grid)
      end

      private

      def string_to_cell_grid(string)
        Grid.from_s(string) do |char|
          @cell_serializer.char_to_cell(char)
        end
      end

      def cell_grid_to_string(cell_grid)
        cell_grid.to_s do |cell|
          @cell_serializer.cell_to_char(cell)
        end
      end
    end
  end
end
