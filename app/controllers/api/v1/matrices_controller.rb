# API controller to process matrix input
# Returns largest submatrix containing only 1s
module Api
  module V1
    class MatricesController < ApplicationController
      protect_from_forgery with: :null_session

      def largest_submatrix
        matrix = params[:matrix]

        if matrix.blank?
          render json: { error: "Matrix is required" }, status: :unprocessable_entity
          return
        end

        result = LargestSubmatrixFinder.new(matrix).call

        render json: { largest_submatrix: result }
      end
    end
  end
end