require "rails_helper"

RSpec.describe PetsController, type: :controller do

  describe "GET #pets" do
    it "returns http success" do
      pets_path
      expect(response).to have_http_status(:success)
    end
  end

end
