module Lifelike
  class Grid
    ROW_DELIMITER = "\n"
    CELL_DELIMITER = ''

    def initialize(rows)
      @rows = rows
    end

    def self.from_s(string)
      new(
        string.split(ROW_DELIMITER).map do |row_string|
          row_string.split(CELL_DELIMITER).map do |char|
            yield(char)
          end
        end
      )
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

    def to_s
      @rows.map do |row|
        row.map do |cell|
          yield(cell)
        end.join(CELL_DELIMITER)
      end.join(ROW_DELIMITER)
    end

    private

    def neighbors(row_index, col_index)
      neighbor_shifts.flat_map do |row_shift, col_shift|
        nonwrapping_fetch(row_index + row_shift, col_index + col_shift)
      end.compact
    end

    def neighbor_shifts
      # rubocop:disable all
      [
        [-1, -1], [-1,  0], [-1,  1],
        [ 0, -1],           [ 0,  1],
        [ 1, -1], [ 1,  0], [ 1,  1],
      ]
      # rubocop:enable all
    end

    def nonwrapping_fetch(row_index, col_index)
      @rows.fetch(row_index, [])[col_index] if row_index >= 0 && col_index >= 0
    end
  end
end
