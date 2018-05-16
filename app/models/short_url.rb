class ShortUrl < ApplicationRecord

  URL_REGEXP = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\Z/ix

  validates :base_url, format: { with: URL_REGEXP, message: 'Invalid URL' }
  validates :base_url, presence: true, on: :create

  before_create :sanitize_url

  def sanitize_url
    self.base_url = self.base_url.downcase.strip
  end

end
