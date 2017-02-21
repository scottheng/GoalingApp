require 'spec_helper'
require 'rails_helper'

feature "managing goals" do

  feature "when logged out" do
    scenario "redirects to sign in page" do
      visit new_goal_url

      expect(page).not_to have_content("New Goal")
    end
  end

  feature "when logged in" do
    before(:each) do
      User.create(username: "Dallas", password: "secret")
      login_dallas
    end

    feature "creating a new goal" do
      scenario "renders goal creation page" do
        visit new_goal_url
        expect(page).to have_content("New Goal")
      end

      scenario "creates a new goal and redirects to show page" do
        visit new_goal_url

        fill_in "Title", with: "Pizza"
        fill_in "Description", with: "Eat Pizza"
        click_button "Create new goal"

        expect(page).to have_content("Pizza")
      end
    end

    feature "edit an existing goal" do
      scenario "renders goal editing page"

      scenario "edits a goal and redirects to show page"
    end

    feature "showing a goal" do
      scenario "renders goal show page"
    end

    feature "deleting a goal" do
      scenario "removes goal and redirects to user page"
    end
  end
end
