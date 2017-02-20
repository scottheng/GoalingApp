require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    User.new(username: 'Dallas', password: 'secret')
  end

  # Validations
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_uniqueness_of(:session_token) }

  # Class methods
  describe "::find_by_credentials" do
    it "should return the user if valid credentials" do
      user.save
      found_user = User::find_by_credentials("Dallas", "secret")

      expect(found_user).to eq(user)
    end
  end

  describe "::generate_session_token" do
    it "creates a token" do
      token = User::generate_session_token

      expect(token).not_to be_nil
    end
  end
end
