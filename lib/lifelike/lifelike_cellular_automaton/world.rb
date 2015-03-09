module Lifelike
  class LifelikeCellularAutomaton
    class World
      def initialize(grid, rules:, cell_char_to_bool:)
        @grid = grid
        @rules = rules
        @cell_char_to_bool = cell_char_to_bool
      end

      def self.from_s(string, rules)
        cell_char_to_bool = cell_char_to_bool(string)
        new(
          Grid.from_s(string) do |char|
            cell_char_to_bool.fetch(char)
          end,
          rules: rules,
          cell_char_to_bool: cell_char_to_bool
        )
      end

      def self.cell_char_to_bool(string)
        # From dead to alive
        char_precedence = [' ', '_', '.', 'o', '0', 'O', '1', '*', '#', 'x', 'X']
        c1, c2 = string.chars.select { |c| char_precedence.include?(c) }.reduce({}) do |frequencies, char|
          frequencies[char] = frequencies.fetch(char, 0) + 1
          frequencies
        end.sort_by { |c, f| -f }.take(2).to_h.keys
        if char_precedence.index(c1) > char_precedence.index(c2)
          alive = c1
          dead = c2
        else
          alive = c2
          dead = c1
        end
        { alive => true, dead => false }
      end

      def to_s
        @grid.to_s do |cell_alive|
          @cell_char_to_bool.invert.fetch(cell_alive)
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
          cell_char_to_bool: @cell_char_to_bool
        )
      end
    end
  end
end
