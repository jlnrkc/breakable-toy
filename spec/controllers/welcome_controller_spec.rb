require "rails_helper"

RSpec.describe WelcomeController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      root_path
      expect(response).to have_http_status(:success)
    end
  end

end
