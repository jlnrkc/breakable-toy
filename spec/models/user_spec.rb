require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_valid(:email).when('email@gmail.com') }
  it { is_expected.not_to have_valid(:name).when(nil, '') }
end
