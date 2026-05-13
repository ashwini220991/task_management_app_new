require 'rails_helper'

RSpec.describe "Matrix API", type: :request do
  describe "POST /api/v1/largest_submatrix" do
    it "returns largest submatrix" do
      post "/api/v1/largest_submatrix",
           params: {
             matrix: [
               [1, 0, 1, 1],
               [0, 1, 0, 1],
               [1, 1, 1, 0],
               [1, 1, 1, 1]
             ]
           }.to_json,
           headers: {
             "CONTENT_TYPE" => "application/json"
           }

      expect(response).to have_http_status(:ok)
    end

    it "rejects empty matrix" do
      post "/api/v1/largest_submatrix",
           params: {
             matrix: []
           }.to_json,
           headers: {
             "CONTENT_TYPE" => "application/json"
           }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "rejects non-binary values" do
      post "/api/v1/largest_submatrix",
           params: {
             matrix: [[1, 2, 0]]
           }.to_json,
           headers: {
             "CONTENT_TYPE" => "application/json"
           }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "rejects jagged matrix" do
      post "/api/v1/largest_submatrix",
           params: {
             matrix: [
               [1, 0],
               [1, 1, 0]
             ]
           }.to_json,
           headers: {
             "CONTENT_TYPE" => "application/json"
           }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "accepts string numeric values" do
      post "/api/v1/largest_submatrix",
           params: {
             matrix: [
               ["1", "0"],
               ["1", "1"]
             ]
           }.to_json,
           headers: {
             "CONTENT_TYPE" => "application/json"
           }

      expect(response).to have_http_status(:ok)
    end
  end
end
