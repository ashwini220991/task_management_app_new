# Finds largest rectangular submatrix containing only 1s
class LargestSubmatrixFinder
  def initialize(matrix)
    @matrix = matrix
  end

  # Calculate largest submatrix
  def call
    rows = @matrix.length
    cols = @matrix.first.length

    max_area = 0
    best_matrix = []

    (0...rows).each do |top|
      temp = Array.new(cols, 1)

      (top...rows).each do |bottom|
        (0...cols).each do |col|
          temp[col] &= @matrix[bottom][col]
        end

        width = 0

        temp.each_with_index do |value, index|
          if value == 1
            width += 1
            area = width * (bottom - top + 1)

            if area > max_area
              max_area = area

              best_matrix = @matrix[top..bottom].map do |row|
                row[(index - width + 1)..index]
              end
            end
          else
            width = 0
          end
        end
      end
    end

    best_matrix
  end
end