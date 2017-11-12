require "spec_helper"

feature "user adds grocery list item" do
  scenario "item added when filled form submitted" do
    visit "/grocery-list"

    fill_in "Name", with: "Coke Zero"
    click_on "Add"

    expect(page).to have_content("Coke Zero")
  end

  scenario "empty li element is not added when form missing name is submitted" do
    visit "/grocery-list"
    click_on "Add"

    expect(page).not_to have_selector("li")
  end
end
