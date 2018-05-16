class ShortUrl < ApplicationRecord

  URL_REGEXP = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\Z/ix
  BASE_62_ENC = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a.collect{|i| i.to_s}
  SHORT_ID_LENGTH = 6

  validates :base_url, format: { with: URL_REGEXP, message: 'Invalid URL' }
  validates :base_url, presence: true, on: :create

  before_create :sanitize_url

  def sanitize_url
    self.base_url = self.base_url.downcase.strip
  end

  def generate_short_url
    needs_regenerate = true

    while (needs_regenerate)
      shortened_url = BASE_62_ENC.sample(SHORT_ID_LENGTH).join
      needs_regenerate = ShortUrl.find_by_shortened_url(shortened_url).present?
    end

      self.shortened_url = shortened_url
  end

  def is_new_url
    !ShortUrl.find_by_base_url(self.base_url).present?
  end

end
