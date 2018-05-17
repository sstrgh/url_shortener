class ShortUrlsController < ApplicationController
  def new
    @short_url = ShortUrl.new
  end

  def create

    # Checks if the url is a valid url
    @short_url = ShortUrl.new(base_url: params[:base_url])
    if !@short_url.valid?
      flash.now[:error] = "URL is invalid!. Please provide a proper url."
      render 'new'
      return
    end

    # Checks if the url to be shortened already exists
    @searched_short_url = ShortUrl.find_by_base_url(@short_url.base_url)
    if @searched_short_url.present?
      flash[:notice] = "URL has already been shortened before. Please find details below."
      redirect_to :action => "show", base_url: @short_url.base_url
      return
    end

  end

  def show

    # Reroutes back to new if the base_url is not found
    if params[:base_url].present?
      @short_url = ShortUrl.find_by_base_url(params[:base_url])
    else
      flash[:notice] = "URL not found, please try again."
      redirect_to :action => "new"
    end

  end

  def reroute
  end

end
