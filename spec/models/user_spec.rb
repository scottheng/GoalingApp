require 'rails_helper'

RSpec.describe User, type: :model do
  # Validations
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_uniqueness_of(:session_token) }

  # Class methods
  describe "::find_by_credentials" do

  end

  describe "::generate_session_token" do

  end
end
