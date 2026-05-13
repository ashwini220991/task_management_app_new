module Api
  module V1
    class MatricesController < ApplicationController
      protect_from_forgery with: :null_session

      def largest_submatrix
        matrix = params[:matrix]

        error = validate_matrix(matrix)

        if error.present?
          render json: { error: error }, status: :unprocessable_entity
          return
        end

        normalized_matrix = matrix.map do |row|
          row.map(&:to_i)
        end

        result = LargestSubmatrixFinder.new(normalized_matrix).find

        render json: {
          largest_submatrix: result
        }, status: :ok
      end

      private

      def validate_matrix(matrix)
        return "Matrix parameter is required" if matrix.nil?
        return "Matrix must be an array" unless matrix.is_a?(Array)
        return "Matrix cannot be empty" if matrix.empty?
        return "Matrix rows must be arrays" unless matrix.all? { |row| row.is_a?(Array) }

        row_length = matrix.first.length
        return "Matrix rows cannot be empty" if row_length.zero?

        matrix.each do |row|
          return "Matrix must be rectangular" unless row.length == row_length
        end

        matrix.flatten.each do |value|
          next if ["0", "1", 0, 1].include?(value)

          return "Matrix must contain only 0 and 1"
        end

        nil
      end
    end
  end
end
