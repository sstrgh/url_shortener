require "rails_helper"

RSpec.describe "Short URLS", type: :system do

  it "User visits new" do
      visit root_path
      expect(page).to have_content "Url Shortener"
  end

  it "flashes error when a invalid url is provided" do
      visit root_path
      fill_in('base_url', :with => 'google')
      click_button('Generate Short Url')

      expect(page).to have_content "URL is invalid!. Please provide a proper url."
      expect(page).to have_css 'div.alert-danger'
  end

  it "flashes warning when url provided already exists" do
      visit root_path
      FactoryBot.create(:short_url)
      fill_in('base_url', :with => 'https://www.google.com/')

      click_button('Generate Short Url')
      expect(page).to have_content "URL has already been shortened before. Please find details below."
      expect(page).to have_css 'div.alert-warning'
      expect(page).to have_content 'https://www.google.com/'
      expect(page).to have_content 'https://127.0.0.1/as12Gx'
  end


end
