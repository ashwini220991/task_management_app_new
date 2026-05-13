require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  it "redirects unauthenticated users" do
    get tasks_path

    expect(response).to redirect_to(new_user_session_path)
  end
end