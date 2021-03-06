module Lifelike
  class Grid
    def initialize(rows)
      @rows = rows
    end

    def map_with_neighbors
      self.class.new(
        @rows.map.with_index do |row, row_index|
          row.map.with_index do |cell, col_index|
            yield(cell, neighbors(row_index, col_index))
          end
        end
      )
    end

    def to_a
      @rows
    end

    def self.from_s(string)
      GridSerializer.load(string) do |char|
        yield(char)
      end
    end

    def to_s
      GridSerializer.dump(self) do |cell|
        yield(cell)
      end
    end

    private

    def neighbors(row_index, col_index)
      neighbor_shifts.flat_map do |row_shift, col_shift|
        nonwrapping_fetch(row_index + row_shift, col_index + col_shift)
      end.compact
    end

    # rubocop:disable all
    def neighbor_shifts
      [
        [-1, -1], [-1,  0], [-1,  1],
        [ 0, -1],           [ 0,  1],
        [ 1, -1], [ 1,  0], [ 1,  1],
      ]
    end
    # rubocop:enable all

    def nonwrapping_fetch(row_index, col_index)
      @rows.fetch(row_index, [])[col_index] if row_index >= 0 && col_index >= 0
    end

    class GridSerializer
      ROW_DELIMITER = "\n"
      CELL_DELIMITER = ''
      def self.load(string)
        Grid.new(
          string.split(ROW_DELIMITER).map do |row_string|
            row_string.split(CELL_DELIMITER).map do |char|
              yield(char)
            end
          end
        )
      end

      def self.dump(grid)
        grid.to_a.map do |row|
          row.map do |cell|
            yield(cell)
          end.join(CELL_DELIMITER)
        end.join(ROW_DELIMITER)
      end
    end
  end
end
