require 'rails_helper'

RSpec.describe 'Matrices API', type: :request do
  it 'returns largest submatrix' do
    matrix = [
      [1,0,1,1],
      [0,1,0,1],
      [1,1,1,0],
      [1,1,1,1]
    ]

    post '/api/v1/largest_submatrix',
         params: { matrix: matrix },
         as: :json

    expect(response).to have_http_status(:success)

    json = JSON.parse(response.body)

    expect(json['largest_submatrix']).to eq([
      [1,1,1],
      [1,1,1]
    ])
  end
end
