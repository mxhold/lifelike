module Lifelike
  class LifelikeCellularAutomaton
    class World
      def initialize(grid, rules:, cell_serializer:)
        @grid = grid
        @rules = rules
        @cell_serializer = cell_serializer
      end

      def self.from_s(string, rules)
        cell_serializer = CellSerializer.new(string)
        new(
          Grid.from_s(string) do |char|
            cell_serializer.char_to_bool(char)
          end,
          rules: rules,
          cell_serializer: cell_serializer
        )
      end

      def to_s
        @grid.to_s do |cell_alive|
          @cell_serializer.bool_to_char(cell_alive)
        end
      end

      def tick(generations)
        (1..generations).reduce(self) do |world, _|
          world.tick_once
        end
      end

      def tick_once
        self.class.new(
          @grid.map_with_neighbors do |cell_alive, neighbors|
            alive_neighbor_count = neighbors.select(&:itself).size
            if cell_alive
              @rules.survives?(alive_neighbor_count)
            else
              @rules.born?(alive_neighbor_count)
            end
          end,
          rules: @rules,
          cell_serializer: @cell_serializer
        )
      end
    end
  end
end
