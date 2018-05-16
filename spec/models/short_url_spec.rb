require 'rails_helper'

RSpec.describe ShortUrl, type: :model do

  it "validates presence of base_url" do
    expect(ShortUrl.new()).not_to be_valid
    expect(ShortUrl.new(base_url: "https://www.google/")).not_to be_valid
    expect(ShortUrl.new(base_url: "https://www.google.com/")).to be_valid
  end


  
end
