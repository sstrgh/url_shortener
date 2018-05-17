require "rails_helper"

RSpec.describe "Short URLS", type: :system do

  it "User visits new" do
      visit root_path
      expect(page).to have_content "AI LINKS"
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
      expect(page).to have_field('base_url', with:'https://www.google.com/')
      expect(page).to have_field('shortened_url', with:'127.0.0.1/as12Gx')
  end

  it "Creates shortened url when url provided is new" do
    visit root_path
    FactoryBot.create(:short_url)
    fill_in('base_url', :with => 'https://www.amazon.com/')

    click_button('Generate Short Url')
    expect(page).to have_content "Successfully shortened URL"
    expect(page).to have_css 'div.alert-success'
    expect(page).to have_field('base_url', with:'https://www.amazon.com/')

    ShortUrl.all.each do |short_url|
      expect(short_url.shortened_url.length).to eq 6
    end
  end

  it "redirects to proper show page when base_url is provided" do
    short_url = FactoryBot.create(:short_url)
    visit root_path + "show?base_url=" + short_url.base_url
    expect(page).to have_field('base_url', with:short_url.base_url)
    expect(page).to have_field('shortened_url', with: '127.0.0.1/' + short_url.shortened_url)
  end

end
