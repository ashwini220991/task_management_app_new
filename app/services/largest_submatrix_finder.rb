# Finds largest rectangular submatrix containing only 1s
class LargestSubmatrixFinder
  def initialize(matrix)
    @matrix = matrix
  end

  def find
    max_area = 0
    best_submatrix = []

    rows = @matrix.length
    cols = @matrix.first.length

    (0...rows).each do |top|
      temp = Array.new(cols, 1)

      (top...rows).each do |bottom|
        (0...cols).each do |col|
          temp[col] &= @matrix[bottom][col]
        end

        current = extract_longest_ones(temp)

        area = current.length * (bottom - top + 1)

        if area > max_area
          max_area = area
          best_submatrix = Array.new(bottom - top + 1) do
            Array.new(current.length, 1)
          end
        end
      end
    end

    best_submatrix
  end

  private

  def extract_longest_ones(array)
    longest = []
    current = []

    array.each do |value|
      if value == 1
        current << 1
        longest = current.dup if current.length > longest.length
      else
        current = []
      end
    end

    longest
  end
end
