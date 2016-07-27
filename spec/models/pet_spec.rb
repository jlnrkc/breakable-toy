require 'rails_helper'

RSpec.describe Pet, type: :model do
  it { is_expected.to have_valid(:animal_type).when('cat') }
  it { is_expected.to have_valid(:name).when('Bob') }
  it { is_expected.to_not have_valid(:animal_type).when(nil, '') }
  it { is_expected.to_not have_valid(:name).when(nil, '') }
end
