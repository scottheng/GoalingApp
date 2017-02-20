require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in "Username", with: 'Dallas'
      fill_in "Password", with: 'secret'
      click_button('Sign Up')

      expect(page).to have_content("Dallas")
    end

  end

end

feature "logging in" do
  before(:each) do
    User.create(username: 'Dallas', password: 'secret')
  end

  scenario "shows username on the homepage after login" do
    login_dallas

    expect(page).to have_content("Dallas")
  end

end

feature "logging out" do
  before(:each) do
    user = User.create(username: "Dallas", password: "secret")
  end

  scenario "begins with a logged out state" do
    visit new_user_url
    expect(page).not_to have_content("Dallas")
  end

  scenario "doesn't show username on the homepage after logout" do
    login_dallas
    click_button "Logout"
    expect(page).not_to have_content("Dallas")
  end

end
