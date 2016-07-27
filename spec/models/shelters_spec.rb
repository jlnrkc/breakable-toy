require 'rails_helper'

RSpec.describe Shelter, type: :model do
  it { is_expected.to have_valid(:name).when('MSPCA') }
  it { is_expected.to have_valid(:location).when('MA') }
  it { is_expected.to_not have_valid(:name).when(nil, '') }
  it { is_expected.to_not have_valid(:location).when(nil, '') }
end
