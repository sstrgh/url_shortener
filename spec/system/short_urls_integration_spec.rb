require "rails_helper"

RSpec.describe "Short URLS", type: :system do
  it "User visits new" do
      visit root_path
      expect(page).to have_content "Url Shortener"
  end
end
