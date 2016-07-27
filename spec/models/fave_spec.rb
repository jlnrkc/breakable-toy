require 'rails_helper'

RSpec.describe Fave, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:pet) { FactoryGirl.create(:pet) }
  it { is_expected.to have_valid(:user_id).when(user.id) }
  it { is_expected.to have_valid(:pet_id).when(pet.id) }
  it { is_expected.to_not have_valid(:user_id).when(nil, '') }
  it { is_expected.to_not have_valid(:pet_id).when(nil, '') }
end
