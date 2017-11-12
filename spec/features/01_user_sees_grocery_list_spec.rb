require "spec_helper"

feature "user sees grocery list" do
  scenario "user views all grocery list items" do
    CSV.open("grocery_list.csv", "a", headers: true) do |file|
      name = "tacos"
      file.puts([name])
    end

    visit "/grocery-list"
    expect(page).to have_content("tacos")
  end

  scenario "user sees all grocery items at root path" do
    CSV.open("grocery_list.csv", "a", headers: true) do |file|
      name = "tacos"
      file.puts([name])
    end
    
    visit "/"
    expect(page).to have_content("tacos")
  end
end
