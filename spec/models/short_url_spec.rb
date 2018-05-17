require 'rails_helper'

RSpec.describe ShortUrl, type: :model do

  it "validates presence of base_url" do
    expect(ShortUrl.create()).not_to be_valid
    expect(ShortUrl.create(base_url: "https://www.google/")).not_to be_valid
    expect(ShortUrl.create(base_url: "https://www.google.com/")).to be_valid
  end

 it "sanitizes base_url on create" do
   short_url = ShortUrl.create(base_url: "https://www.Google.com/   ")
   expect(short_url.base_url).to eq "https://www.google.com/"
 end

 it "returns a 6 char short_url code" do
   short_url = ShortUrl.create(base_url: "https://www.google.com/")
   expect(short_url.generate_short_url.length).to eq 6
 end

end
