require "rails_helper"

feature "User signs up" do
  scenario "User signs up successfully" do
    visit root_path
    click_link "Sign Up"
    fill_in "Email", with: "test@gmail.com"
    fill_in "Password", with: "asdfgh"
    fill_in "Password confirmation", with: "asdfgh"
    click_button "Sign Up"
    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  scenario "User leaves blank fields" do
    visit root_path
    click_link "Sign Up"
    expect(page).to have_content "can't be blank"
    expect(page).to_not have_content "Sign Out"
  end

  scenario "Password is not long enough" do
    visit root_path
    click_link "Sign Up"
    fill_in "Email", with: "test@gmail.com"
    fill_in "Password", with: "asdfg"
    fill_in "Password confirmation", with: "asdfg"
    click_button "Sign Up"
    expect(page).to have_content "doesn't match"
    expect(page).to_not have_content "Sign Out"
end

  scenario "Password confirmation doesn't match" do
    visit root_path
    click_link "Sign Up"
    fill_in "Email", with: "test@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password1"
    click_button "Sign Up"
    expect(page).to have_content "Password is too short"
    expect(page).to_not have_content "Sign Out"
  end
end
