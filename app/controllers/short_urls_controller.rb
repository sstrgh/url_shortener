class ShortUrlsController < ApplicationController
  def new
    @short_url = ShortUrl.new
  end

  def create

    @short_url = ShortUrl.new(base_url: params[:base_url])

    if !@short_url.valid?
      flash[:error] = "URL is invalid!. Please provide a proper url."
      render 'new'
      return
    end

  end

  def show
  end

end
